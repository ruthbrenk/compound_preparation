#!/usr/bin/env python

import os, sys
import my_mysql as mysql

if len(sys.argv) <> 7 :
	print 'cl_cpd_props.py <path to scripts> <queue> <username> <password> <project> <prop (use "all" for all)>'
	sys.exit(1)

path = sys.argv[1]
queue = sys.argv[2]
username = sys.argv[3]
password = sys.argv[4]
project = sys.argv[5]
prop = sys.argv[6]



#check db connection
conn=mysql.connect2server(password, username,'purchasable')  
cursor = conn.cursor ()

#check project
command = 'select unique_compounds, supplier_info_table, supplier_table from projects where project = "' + project + '"'
#print command
cursor.execute(command)
results=cursor.fetchall()
if len(results) == 0:
	print 'project does not exist'
	conn.close()
	sys.exit(1)
conn.close()




files = os.listdir('./')

first_bit = "#$ -S /bin/tcsh\n#$ -cwd\nworkdir=/global/work/$USER/$PBS_JOBID\nmkdir -p $workdir\ncd $PBS_O_WORKDIR\n"

#tpsa_file = first_bit + 'tpsa.py '
#match_count_file = first_bit + 'match_count.py '
#unwanted_file = first_bit + 'unwanted_groups.py '

files.sort()

if prop == 'all' or prop =='filter_des':
	os.makedirs('filter_des')
if prop == 'all' or prop =='tpsa':
	os.makedirs('tpsa')
if prop == 'all' or prop =='match_count':
	os.makedirs('match_count')
if prop == 'all' or prop =='unwanted':
	os.makedirs('unwanted')



if prop == 'all' or prop =='filter_des':
  for i in files:

	if i[-4:] == '.smi':
		#filter_des 

		file_name = i[:-4] + '_filter_des.bin'
		start_file = open(file_name, 'w')
		start_file.write(first_bit)
		start_file.write('executable=' + path + 'filter_descriptors.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
		start_file.write('executable=' + path + 'mysql_load_filter_des.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
		start_file.write('cp ' + i + ' $workdir\n')
		start_file.write('cd $workdir\n')
		start_file.write('./filter_descriptors.py ' + i + ' ' + i[:-4] + '_filter_descriptors.txt\n')
		start_file.write('./mysql_load_filter_des.py ' + username + ' ' + password + ' ' + i[:-4] + '_filter_descriptors.txt ' + project +'\n')
		start_file.write('cp ' +  i[:-4] + '_filter_descriptors.txt $PBS_O_WORKDIR/filter_des')
		start_file.close()
		os.system('chmod 744 '  + file_name)
		command = 'qsub -V -q ' + queue + ' ' + file_name
		print command
		os.system(command)

if prop == 'all' or prop =='tpsa':

  for i in files:

	if i[-4:] == '.smi':
		#tpsa
		file_name = i[:-4] + '_tpsa.bin'
		start_file = open(file_name, 'w')
		start_file.write(first_bit)
		start_file.write('executable=' + path + 'tpsa.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
		start_file.write('executable=' + path + 'mysql_load_tpsa.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
		start_file.write('cp ' + i + ' $workdir\n')
		start_file.write('cd $workdir\n')
		start_file.write('./tpsa.py --i=' + i + ' --o=' + i[:-4] + '_tpsa.txt  --SandP\n')
		start_file.write('./mysql_load_tpsa.py ' + username + ' ' + password + ' ' + i[:-4] + '_tpsa.txt ' + project +'\n')
		start_file.write('cp ' +  i[:-4] + '_tpsa.txt $PBS_O_WORKDIR/tpsa')
		start_file.close()
		os.system('chmod 744 '  + file_name)
		command = 'qsub -V -q ' + queue + ' ' + file_name
		print command
		os.system(command)

if prop == 'all' or prop =='match_count':
  for i in files:

	if i[-4:] == '.smi':
		#match count
		file_name = i[:-4] + '_mc.bin'
		start_file = open(file_name, 'w')
		start_file.write(first_bit)

		start_file.write('executable=' + path + 'match_count.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
		start_file.write('executable=' + path + 'mysql_load_match_count.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
		start_file.write('cp ' + i + ' $workdir\n')
		start_file.write('cd $workdir\n')
		start_file.write('./match_count.py ' + i + ' ' + i[:-4] + '_match_count.txt\n')
		start_file.write('./mysql_load_match_count.py ' + username + ' ' + password + ' ' + i[:-4] + '_match_count.txt ' + project +'\n')
		start_file.write('cp ' +  i[:-4] + '_match_count.txt $PBS_O_WORKDIR/match_count')
		start_file.close()
		os.system('chmod 744 '  + file_name)
		command = 'qsub -V -q ' + queue + ' ' + file_name
		print command
		os.system(command)

if prop == 'all' or prop =='unwanted':

  for i in files:

	if i[-4:] == '.smi':
		#unwanted groups
		file_name = i[:-4] + '_uw_start.bin'
		start_file = open(file_name, 'w')
		start_file.write(first_bit)

		start_file.write('executable=' + path + 'unwanted_groups.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
		start_file.write('executable=' + path + 'mysql_load_unwanted_groups.py \ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
		start_file.write('cp ' + i + ' $workdir\n')
		start_file.write('cd $workdir\n')
		start_file.write('./unwanted_groups.py ' + i + ' ' + i[:-4] + '.txt\n')
		start_file.write('./mysql_load_unwanted_groups.py ' + username + ' ' + password + ' ' + i[:-4] + '.txt ' + project +'\n')
		start_file.write('cp ' +  i[:-4] + '.txt $PBS_O_WORKDIR/unwanted')
		start_file.close()
		os.system('chmod 744 '  + file_name)
		command = 'qsub -V -q ' + queue + ' ' + file_name
		print command
		os.system(command)

	


	
	



