#!/usr/bin/env python


#get smiles for certain molecules
import string,os, sys
import MySQLdb
import my_mysql as mysql

if len(sys.argv) <> 5:
	print 'mysql_get_smiles_chunks.py <query file> <prefix of output file> <size of chunks> <MFC codes:True|False>'
	sys.exit(1)


query = open(sys.argv[1], 'r')
out_file = open(sys.argv[2] + '_1' + '.smi', 'w')
size = int(sys.argv[3])
mfc_codes = sys.argv[4]

print mfc_codes



if mfc_codes == 'True':
	mfc_codes = True
else:
   mfc_codes = False



#-------------------------------------
username = 'webuser'
password = '' 


conn=mysql.connect2server(password, username,'purchasable')  			  
			  
cursor = conn.cursor ()

list = []

command = query.readline()

print command

cursor.execute(command)

count = 0
new_number = 1
old_number = 1
rows = cursor.fetchall ()
for row in rows:
   new_number = count / size + 1 #=1 necessary, otherwise first file will always be called 0
   if new_number <> old_number :
	old_number = new_number
	out_file.close()
	new_name = sys.argv[2] + '_' + str(new_number) + '.smi'
	out_file = open(new_name, 'w')   
   smiles = row[1]
   #print smiles
   smiles = string.strip(smiles)
   number = str(row[0])
   if mfc_codes:
   	new_name = 'MFC' + number.rjust(9)
   	new_name = new_name.replace(' ', '0')
   	out_file.write(smiles + '\t' + new_name + '\n')
   else:
   	out_file.write(smiles + '\t' + str(row[0]) + '\n')
   count = count + 1


cursor.close ()
conn.close ()
out_file.close()
query.close()
