#!/usr/bin/env python

import os, sys
import my_mysql as mysql
 
print len(sys.argv)

if len(sys.argv) < 8 or  len(sys.argv) > 9:
	print 'cl_charger_taut.py  <directory with charger.py and tautomerizer.py> <supplier> <Supplier Id numer field> <username> <password> <project> <initial> <comment (optional)>'
	sys.exit(1)

path =  sys.argv[1]
supplier = sys.argv[2]
id_field = sys.argv[3]
username = sys.argv[4]
password = sys.argv[5]
project = sys.argv[6]
initial = sys.argv[7]

if len(sys.argv) == 9:
	comment = sys.argv[8]
else:
	comment = ''


#check db connection
conn=mysql.connect2server(password, username,'purchasable')  

cursor = conn.cursor ()

#check project
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

#get supplier_fied from supplier_table
command = "show fields from " + sup_table
cursor.execute(command)
results=cursor.fetchall()
for result in results:
	if result[3] == 'PRI':
		supplier_field = result[0]
		break

#check supplier
command = "SELECT prefix from " + sup_table + " where " + supplier_field + " = '" + supplier + "'"
cursor.execute(command)
results = cursor.fetchall()
if len (results) <> 1:
	print 'something wrong with your supplier or centre'
	sys.exit(1)

conn.close()


files = os.listdir('./')

clean_list = []
max_file_number = 0

#remove all none .smi from files
for i in files:
	if (i[-4:] == '.sdf') or (i[-4:] == '.SDF'):
		clean_list.append(i)

files = clean_list

path = sys.argv[1]


files.sort()

first_bit = "#$ -S /bin/tcsh\n#$ -cwd\nworkdir=/global/work/$USER/$PBS_JOBID\nmkdir -p $workdir\ncd $PBS_O_WORKDIR\n"



for i in files:
	file_name = i[:-4] + '_start.bin'
	start_file = open(file_name, 'w')
	start_file.write(first_bit)

	start_file.write('executable=' + path + 'charger.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
	start_file.write('executable=' + path + 'tautomerizer.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
	start_file.write('executable=' + path + 'mysql_load_unique_smiles.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
	start_file.write('cp ' + i + ' $workdir\n')
	start_file.write('cd $workdir\n')
	start_file.write('./charger.py ' + i + ' ' + i[:-4] + '_charged.smi False 7 0 '  + id_field + '\n')
	start_file.write('./tautomerizer.py ' +i[:-4] + '_charged.smi' + ' ' + i[:-4] + '_charged_taut.smi False\n')
	start_file.write('./mysql_load_unique_smiles.py ' + username + ' ' +  password + ' ' + i[:-4] + '_charged_taut.smi' + ' ' + project  + ' ' + initial + ' ' + supplier + ' ' + comment)

	start_file.write('cp ' +  i[:-4] + '_charged.smi $PBS_O_WORKDIR\n')
	start_file.write('cp ' +  i[:-4] + '_charged_taut.smi $PBS_O_WORKDIR\n')


	start_file.close()
	os.system('chmod 744 '  + file_name)
	command = 'qsub -V -q short ' + file_name
	print command
	os.system(command)



	
	
