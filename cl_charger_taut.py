#!/usr/bin/env python

import os, sys
 

if len(sys.argv) < 3 or  len(sys.argv) > 4:
	print 'cl_charger_taut.py  <directory with charger.py and tautomerizer.py> <SDF:True|False> (<Supplier Id numer field>)'
	sys.exit(1)

sdf  = sys.argv[2]
if sdf == 'True':
	sdf = True
	type = '.sdf'
	if len(sys.argv) <> 4:
		print 'cl_charger_taut.py  <directory with charger.py and tautomerizer.py> <SDF:True|Fase> (<Supplier Id numer field>)'
		sys.exit(1)
	else:
		id_field = sys.argv[3]
else:
	type = '.smi'
	id_field = 'xxx' #is not needed
	sdf = False


files = os.listdir('./')

clean_list = []
max_file_number = 0

#remove all none .smi from files
for i in files:
	if (sdf and i[-4:] == '.sdf') or (not sdf and i[-4:] == '.smi'):
		clean_list.append(i)

files = clean_list

path = sys.argv[1] + '/'


files.sort()

first_bit = "#$ -S /bin/tcsh\n#$ -cwd\nworkdir=/global/work/$USER/$PBS_JOBID\nmkdir -p $workdir\ncd $PBS_O_WORKDIR\n"



for i in files:
	file_name = i[:-4] + '_start.bin'
	start_file = open(file_name, 'w')
	start_file.write(first_bit)

	start_file.write('executable=' + path + 'charger.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
	start_file.write('executable=' + path + 'tautomerizer.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
	start_file.write('cp ' + i + ' $workdir\n')
	start_file.write('cd $workdir\n')
	start_file.write('./charger.py ' + i + ' ' + i[:-4] + '_charged.smi False 7 0 '  + id_field + '\n')
	start_file.write('./tautomerizer.py ' +i[:-4] + '_charged.smi' + ' ' + i[:-4] + '_charged_taut.smi False\n')

	start_file.write('cp ' +  i[:-4] + '_charged.smi $PBS_O_WORKDIR\n')
	start_file.write('cp ' +  i[:-4] + '_charged_taut.smi $PBS_O_WORKDIR')


	start_file.close()
	os.system('chmod 744 '  + file_name)
	command = 'qsub -V -q short ' + file_name
	print command
	os.system(command)



	
	
