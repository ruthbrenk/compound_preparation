#!/usr/bin/env python

#load smiles in table, identifier in supplier table

import string,os, sys,datetime,chemistry
import my_mysql as mysql
import MySQLdb

if len(sys.argv) < 7 or len(sys.argv) > 8:
	print 'mysql_load_unique_smiles.py  <username> <password> <smiles.smi> <project> <initial> <supplier|centre> <comment (optional)>'
	sys.exit(1)

username = sys.argv[1]
password = sys.argv[2]
data_file = open(sys.argv[3], 'r')
project = sys.argv[4]
initial = sys.argv[5]
supplier = sys.argv[6]
orphans = open(sys.argv[3][:-4] + '_orphans.txt', 'w')
if len(sys.argv) == 8:
	comment = sys.argv[7]
else:
	comment = ''

#date_of_update 
utc_datetime = datetime.datetime.utcnow()
date_of_update  = str(utc_datetime.strftime("%Y-%m-%d"))

lost_ids = []
#-------------------------------------
 
conn=mysql.connect2server(password, username,'purchasable')  			  
			  
cursor = conn.cursor ()

#get table names

command = 'select unique_compounds, supplier_info_table, supplier_table from projects where project = "' + project + '"'
print command
cursor.execute(command)
results=cursor.fetchall()
if len(results) == 0:
	print 'project does not exist'
	sys.exit(1)

table = results[0][0]
sup_info_table = results[0][1]
sup_table = results[0][2]
print table, sup_info_table, sup_table

#get comp_id, smiles_field from table
command = "show fields from " + table
cursor.execute(command)
results=cursor.fetchall()
for result in results:
	if result[3] == 'PRI':
		id_field = result[0]
	elif result[0].find('smiles') <> -1:
		smiles_field = result[0]

#get supplier_fied from supplier_table
command = "show fields from " + sup_table
cursor.execute(command)
results=cursor.fetchall()
for result in results:
	if result[3] == 'PRI':
		supplier_field = result[0]
		break

#get supplier_id_field, info_field from supplier_info_table
command = "show fields from " + sup_info_table
cursor.execute(command)
results=cursor.fetchall()
for result in results:
	if result[3] == 'PRI':
		supplier_id_field = result[0]
	elif result[0].find('info') <> -1:
		info_field = result[0]



#get supplier prefix
command = "SELECT prefix from " + sup_table + " where " + supplier_field + " = '" + supplier + "'"
cursor.execute(command)
results = cursor.fetchall()
if len (results) <> 1:
	print 'something wrong with your supplier or centre'
	sys.exit(1)
else:
	prefix = results[0][0]


#LOCK TABLEs, OTHERWISE PARALLEL UPLOADING WILL END IN CHAOS
command = "lock table " + table + " write, " + sup_info_table + " write"
print command
print 'here'
cursor.execute(command)
print 'there'


print "insert data"

counter = 0

new_smiles = {}

for i in data_file.xreadlines():
    #smiles, identifier, charge = string.split(i.strip(),'\t')
    smiles, identifier = string.split(i.strip(),'\t')

    #mysql interpretes \ as special characters -> change
    smiles = mysql.encode_smiles(smiles)

    if len(smiles) < 255: #skipp long smiles, too large

	    if new_smiles.has_key(identifier):
		new_smiles[identifier].append(smiles)
	    else:
		new_smiles[identifier] = [smiles]


	    #if smiles contains / or \\ => invert stereocenters and append this smile 
	    if smiles.find('/') <> -1 or smiles.find('\\') <> -1:
	    	new_smiles[identifier].append(chemistry.swap_stereoisomers(smiles))
    else:
	print 'skipped ' + smiles, identifier, ' too long'



identifiers = new_smiles.keys()
  


for identifier in identifiers:
    exists = False
    for smi in new_smiles[identifier]:
#	if not exists and smiles in unique_smiles_list:
	if not exists:
		command = "SELECT " + smiles_field + ", " + id_field + " from " + table + " where " + smiles_field + "= '" + smi[:255] + "' LIMIT 1"
		#print command
		cursor.execute(command)
		result = cursor.fetchall()
		if len(result) > 0:
			exists = True
			id = result[0][1]
	
    if not exists:
	#insert data
	command = "INSERT INTO " + table + " (" + smiles_field + ") VALUES ('" + smi  + "')"
	#print command
	cursor.execute(command)
	if counter == 0:
		#get first new id number (this assumes, that new entries are not added in the middle of a table)
		command = "SELECT * from " + table + " where " + smiles_field + " = '" + smi[:255] + "' LIMIT 1"		
		#print command
		cursor.execute(command)
		#print cursor.fetchall()
		#print 'lenght', len(cursor.fetchall())
		id = cursor.fetchall()[0][0]
		#print id
		counter = id
	else:
		counter = counter + 1
		id = counter
	

		 
    #update supplier table
    #check that compound does not already exists
    command = "SELECT " + supplier_id_field + ", " + info_field +  ", " + id_field + " from " + sup_info_table + " WHERE " + supplier_id_field + "= '" + prefix + identifier + "'"
    command = command + " and " + supplier_field + " = '" + supplier + "'"
    #print command
    cursor.execute(command)
    result = cursor.fetchall()
    if len(result) > 0:
	unique_id = result[0][2]
	    
	if not exists:
	    #the compound was new but the supplier id number is already in table -> points now to wrong cpd
	        
		command = "update " + sup_info_table + " set " + id_field + "=" + str(id) + " where " +  supplier_id_field + " = '" + prefix + identifier  + "'"
		cursor.execute(command)
		#other info is updated below
		lost_ids.append(unique_id)	    
	else:
		#this is an old cpd, but the supplier_id could still be pointing to the wrong smiles if there was an issue with the datbase before
		if unique_id <> id:
			#points to wrong cpd
			command = "update " + sup_info_table + " set " + id_field + "=" + str(id) + " where " +  supplier_id_field + " = '" + prefix + identifier + "'"
			cursor.execute(command)
			#other info is updated below
			lost_ids.append(unique_id)	   
			
	#print 'compound from this supplier already exits'

	command = "update " + sup_info_table + " set compound_availability = 'yes', updated_by = '" + initial + "', date_of_update = '" + date_of_update + "', " + info_field + " = '" + comment + "' where " + supplier_id_field + " = '" + prefix + identifier + "' and " + supplier_field + " = '" + supplier + "'"
	#concat does not work on Null fields
	if result[0][1]: #not empty field
		command = command.replace(info_field + " =", info_field + " = concat(")
		command = command.replace("where", ", ', ', " + info_field + ") where")	
	#else:
		#command =  "update " + sup_info_table + " set compound_availability = 'yes', updated_by = '" + initial + "', date_of_update = '" + date_of_update + "', " + info_field + " = concat('" + comment + " ', " + info_field + ") where " + supplier_id_field + " = '" + prefix + identifier + "' and " + supplier_field + " = '" + supplier + "'"
	#print command
	cursor.execute(command)


    else: # supplier_code does not exists
      command = "INSERT INTO " + sup_info_table + " (" + supplier_field + ", " + id_field + ", " + supplier_id_field + ", date_of_update,updated_by,compound_availability," + info_field + ") VALUES ('"  
      command = command + supplier + "', " + str(id) + ", '" + prefix + identifier + "', '" + date_of_update + "', '" + initial + "', 'yes', '" + comment + "')" 
      #print command
      cursor.execute(command)
      error = cursor.fetchall()
      if len(error) <> 0 :
		print 'error updating supplier info'
		
#check orphans
for id in lost_ids:
	command = "SELECT " + supplier_id_field + " from " + sup_info_table + " WHERE " + id_field + " = " + str(id) + " limit 1"
	cursor.execute(command)
	result = cursor.fetchall()
	if len(result) == 0:
			print id, ' has no supplier'
			orphans.write(str(id) + '\n')

#next line necessary for InnoDB tables, otherwise updates don't show up
conn.commit()
#unlock tables
command = "unlock tables"
cursor.execute(command)
cursor.close()
conn.close ()
orphans.close()
print 'done'
