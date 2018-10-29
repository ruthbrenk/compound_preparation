#!/usr/bin/python

import os, sys


if not ((len(sys.argv) == 5) or (len(sys.argv) ==7 ) ):
	print 'mysql_get_smiles_smarts.py <path to directory with mysql_get_smiles_smarts.py> <query file> <file with smarts patterns> <output file (prefix)> <chunk size> <max rows> (last two parameters are optional)'
	print 'Note: smarts file must be of format: smarts tab id'
	sys.exit(1)
elif len(sys.argv) ==7:
	try:
		chunk_size = int(sys.argv[5])
		max_rows = int(sys.argv[6])
		chunks = True
	except:
		print 'limits must be integers'
		sys.exit(1)
else:
	chunks = False

path = sys.argv[1]
query = sys.argv[2]
smarts_file = sys.argv[3]
out_file = sys.argv[4]


first_bit = "#$ -S /bin/tcsh\n#$ -cwd\nworkdir=/global/work/$USER/$PBS_JOBID\nmkdir -p $workdir\ncd $PBS_O_WORKDIR\n"

if not chunks:
	file_name = out_file + '_start.bin'
	start_file = open(file_name, 'w')
	start_file.write(first_bit)
	start_file.write('executable=' + path + 'mysql_get_smiles_smarts.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
	start_file.write('cp ' + query + ' $workdir\n')
	start_file.write('cp ' + smarts_file + ' $workdir\n')
	start_file.write('cd $workdir\n')
	start_file.write('./mysql_get_smiles_smarts.py ' +query + ' ' + smarts_file + ' ' + out_file + '.smi\n')
	start_file.write('cp ' +  out_file  + '.smi $PBS_O_WORKDIR')


	start_file.close()
	os.system('chmod 744 '  + file_name)
	command = 'qsub -V -q short ' + file_name
	print command
	os.system(command)

else:
	start = 0
	while start < max_rows:
		limit_start = start
		start = limit_start + chunk_size

		file_name = out_file + '_' + str(limit_start) + '_start.bin'
		start_file = open(file_name, 'w')
		start_file.write(first_bit)
		start_file.write('executable=' + path + 'mysql_get_smiles_smarts.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
		start_file.write('cp ' + query + ' $workdir\n')
		start_file.write('cp ' + smarts_file + ' $workdir\n')
		start_file.write('cd $workdir\n')
		start_file.write('./mysql_get_smiles_smarts.py ' +query + ' ' + smarts_file +  ' ' + out_file + '_' + str(limit_start) + '.smi' + ' ' + str(limit_start) + ' ' + str(chunk_size) + '\n')
		start_file.write('cp ' +  out_file   + '_' + str(limit_start) + '.smi $PBS_O_WORKDIR')

		start_file.close()
		os.system('chmod 744 '  + file_name)
		command = 'qsub -V -q short ' + file_name
		print command
		os.system(command)

	
	
