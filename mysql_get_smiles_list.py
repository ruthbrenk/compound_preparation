#!/usr/bin/env python


#get smiles for certain molecules
import string,os, sys
import my_mysql as mysql
import MySQLdb

if len(sys.argv) <> 6:
	print 'mysql_get_smiles_list.py <query file> <file with cpds ids> <prefix output file> <size of chunks> <MFC codes:True|False>' 
	print 'Note: query must end with "where statement", e. g. "... where id ="'
	sys.exit(1)



query = open(sys.argv[1], 'r')
in_file = open(sys.argv[2], 'r')
out_file = open(sys.argv[3] + '_1' + '.smi', 'w')
size = int(sys.argv[4])
mfc_codes = sys.argv[5]

print mfc_codes, size



if mfc_codes == 'True':
	mfc_codes = True
else:
   mfc_codes = False



#-------------------------------------

  
conn=mysql.connect2server('','webuser', 'purchasable')  			  
			  
cursor = conn.cursor ()

basic_command = query.readline()
basic_command = basic_command.strip()

count = 0
new_number = 1
old_number = 1

for i in in_file.readlines():
   	count = count + 1
   	new_number = count / size + 1 #=1 necessary, otherwise first file will always be called 0
   	if new_number <> old_number :
		old_number = new_number
		out_file.close()
		new_name = sys.argv[3] + '_' + str(new_number) + '.smi'
		out_file = open(new_name, 'w') 

	code = string.strip(i)
	code = code.replace('MFCD', '')
	code_number = int(code)
	code = str(code_number)
	command = basic_command + str(code)
	#print command
	cursor.execute(command)
	results = cursor.fetchall()
	for row in results:
 		smiles = row[1]
		if mfc_codes:
   			new_name = 'MFC' + str(row[0]).rjust(9)
   			new_name = new_name.replace(' ', '0')
    		else:
   			new_name = str(row[0])
   		smiles = string.strip(smiles)
   		out_file.write(smiles + '\t' + new_name + '\n')

cursor.close ()
conn.close ()
query.close()
out_file.close()
in_file.close()
