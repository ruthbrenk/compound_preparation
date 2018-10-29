#!/usr/bin/python

import os, sys

if len(sys.argv) < 5 or len(sys.argv) > 6:
	print 'batch_load_unique_smiles.py  <username> <password> <project> <initial> <comment (optional)>'
	sys.exit(1)

username = sys.argv[1]
password = sys.argv[2]
project = sys.argv[3]
initial = sys.argv[4]
if len(sys.argv) == 6:
	comment = sys.argv[5]
else:
	comment = ''

files = os.listdir('./')
files.sort()


for supplier in files:
	print supplier
	smi_files = os.listdir('./' + supplier)
	for file in smi_files:
		if file[-4:] == '.smi':
			#print file
			command = '/homes/brenk/work/scripts/mysql_scripts/mysql_load_unique_smiles.py ' + username + ' ' + password +' ' + '/' + file + ' ' + supplier + ' ' + date_of_update + ' ' + initial
			print command
			os.system(command)
		
	
