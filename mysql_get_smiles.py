#!/usr/bin/python

#get smiles for certain molecules
import string,os, sys
import my_mysql as mysql
import MySQLdb

if len(sys.argv) <> 3:
	print 'mysql_get_smiles.py <query file> <output file>'
	sys.exit(1)

query = open(sys.argv[1], 'r')
out_file = open(sys.argv[2], 'w')


#-------------------------------------
#-------------------------------------
conn=mysql.connect2server('', 'webuser', 'purchasable')  			  
	  
cursor = conn.cursor ()

list = []

command = query.readline()

cursor.execute(command)
rows = cursor.fetchall ()
for row in rows:
   print row
   for i in row:
	print i
   smiles = row[1]
   #print smiles
   smiles = smiles.replace('Z', '/')
   smiles = smiles.replace('E', '\\')
   smiles = string.strip(smiles)
   out_file.write(smiles + '\t' + str(row[0]) + '\n')
   #out_file.write(smiles + '\t' + 'P' + str(row[0]) + '\n')

cursor.close ()
conn.close ()
query.close()
