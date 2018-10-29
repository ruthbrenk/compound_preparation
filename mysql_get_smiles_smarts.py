#!/usr/bin/python

#get smiles for certain molecules
import MySQLdb
from openeye.oechem import *
import chemistry
import string,os, sys
import my_mysql as mysql


if not ((len(sys.argv) == 4) or (len(sys.argv) ==6 ) ):
	print 'mysql_get_smiles_smarts.py <query file> <file with smarts patterns> <output file> <limit start>  <limit size> (limit parameters are optional)'
	print 'Note: smarts file must be of format: smarts tab id'
	sys.exit(1)
elif len(sys.argv) ==6:
	try:
		limit_start = int(sys.argv[4])
		limit_end = int(sys.argv[5])
		limit = True
	except:
		print 'limit parameters must be integers'
		sys.exit(1)
else:
	limit = False

query = open(sys.argv[1], 'r')
smarts_file = open(sys.argv[2], 'r')
out_file = open(sys.argv[3], 'w')



#-------------------------------------

  
conn=mysql.connect2server('', 'webuser', 'purchasable')  			  
			  
cursor = conn.cursor ()

command = query.readline()
command = command.strip()

if limit:
	command = command + ' limit ' + str(limit_start) + ',' + str(limit_end)

list = []



print command

#some options from the original match.py file
usa=1; asym=1; exph=0; max=0; smartsfile=None; verbose=0;
qmolfile=None; kekule=0; atom_expr=None; bond_expr=None;
smartslist=None; qmollist=None; nowarn=0;

if kekule == 1:
	print '----> kekulizing molecules'
  
smarts_list=chemistry.get_smartslist_file(smarts_file)

patlist= chemistry.get_patlist(smarts_list, atom_expr, bond_expr,max)

cursor.execute(command)
rows = cursor.fetchall ()

print 'start checking smiles'

counter = 0

print len(rows), 'smiles to check'


for row in rows:

   counter = counter + 1
	
   

   if counter/10000 == counter/10000.0:
	print counter	

   smiles = row[1]
   #print smiles
   smiles = smiles.replace('Z', '/')
   smiles = smiles.replace('E', '\\')
   smiles = string.strip(smiles)
   
   mol = OEGraphMol()
	
   if (OEParseSmiles(mol, smiles) ==1):
	for pat,smarts,description in patlist:
      
      		if chemistry.Match(pat,smarts,mol,kekule,verbose,exph,asym,usa) >= 1:
			out_file.write(smiles + '\t' + str(row[0]) + '\n')

   else:
	print 'could not convert '+ smiles
   
   
	

cursor.close ()
conn.close ()
query.close()

print 'done'
