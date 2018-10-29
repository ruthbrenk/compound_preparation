#!/usr/bin/python

#get smiles for certain molecules
import MySQLdb
from openeye.oechem import *
import chemistry
import string,os, sys
import my_mysql as mysql


if len(sys.argv) <>6:
	print 'mysql_get_smiles_smarts.py <query file> <file with smarts patterns> <size of chunks> <MFC codes:True|False> <prefix of output file>'
	print 'Note: smarts file must be of format: smarts tab id'
	sys.exit(1)

query = open(sys.argv[1], 'r')
smarts_file = open(sys.argv[2], 'r')
size = int(sys.argv[3])
mfc_codes = sys.argv[4]
prefix_file = sys.argv [5]

out_file =  open(prefix_file + '_1.smi', 'w')


print mfc_codes


if mfc_codes == 'True':
	mfc_codes = True
else:
   mfc_codes = False



#-------------------------------------

  
conn=mysql.connect2server('', 'webuser', 'purchasable')  			  
			  
cursor = conn.cursor ()

command = query.readline()
command = command.strip()


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


print len(rows), 'smiles to check'

count = 0
new_number = 1
old_number = 1

for row in rows:	

   smiles = row[1]
   #print smiles
   smiles = smiles.replace('Z', '/')
   smiles = smiles.replace('E', '\\')
   smiles = string.strip(smiles)
   
   mol = OEGraphMol()

	
   if OEParseSmiles(mol, smiles):
	for pat,smarts,description in patlist:
      
      		if chemistry.Match(pat,smarts,mol,kekule,verbose,exph,asym,usa) >= 1: 
			new_number = count / size + 1 #=1 necessary, otherwise first file will always be called 0
			if new_number <> old_number : #check if new file has to be opened
					old_number = new_number
					out_file.close()
					new_name = prefix_file + '_' + str(new_number) + '.smi'
					out_file = open(new_name, 'w')   
		   	number = str(row[0])
		   	if mfc_codes:
			   		new_name = 'MFC' + number.rjust(9)
			   		new_name = new_name.replace(' ', '0')
			   		out_file.write(smiles + '\t' + new_name + '\n')
			else:
			   		out_file.write(smiles + '\t' + str(row[0]) + '\n')
			count = count + 1
			break #enough if one pattern per molecule was matched
   
	

cursor.close ()
conn.close ()
query.close()

print 'done'
