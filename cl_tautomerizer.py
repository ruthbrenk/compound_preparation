#!/usr/bin/python

import os, sys

if len(sys.argv) < 2 or  len(sys.argv) >5:
	print 'cl_tautomerizer.py <path to scripts> <debug (optional)> <keep_one (optional)> <post_frag (optional)>'
	sys.exit(1)

path = sys.argv[1]

keep_one = False
post_frag = False
debug = False

print len(sys.argv)

print sys.argv[1]

if len(sys.argv) > 2:
	if sys.argv[2] == 'debug':
		debug = True
	elif sys.argv[2] == 'keep_one':
		keep_one = True
	elif sys.argv[2] == 'post_frag':
		post_frag = True
	if len(sys.argv) > 3:
		if sys.argv[3] == 'debug':
			debug = True
		elif sys.argv[3] == 'keep_one':
			keep_one = True
		elif sys.argv[3] == 'post_frag':
			post_frag = True		
	if len(sys.argv) > 4:
		if sys.argv[4] == 'debug':
			debug = True
		elif sys.argv[4] == 'keep_one':
			keep_one = True
		elif sys.argv[4] == 'post_frag':
			post_frag = True

files = os.listdir('./')

clean_list = []


first_bit = "#$ -S /bin/tcsh\n#$ -cwd\nworkdir=/global/work/$USER/$PBS_JOBID\nmkdir -p $workdir\ncd $PBS_O_WORKDIR\n"


#remove all none .smi from files
for i in files:
	if i[-4:] == '.smi':

		file_name = i[:-4] + '_taut_start.bin'
		start_file = open(file_name, 'w')


		start_file.write(first_bit)
		start_file.write('executable=' + path + 'tautomerizer.py\ncp $executable $workdir\n#pbsdsh -u cp $executable $workdir\n')
		start_file.write('cp ' + i + ' $workdir\n')
		start_file.write('cd $workdir\n')
		start_file.write('./tautomerizer.py ' +i + ' ' + i[:-4] + '_taut.smi False')

		if debug:
			start_file.write('debug ')
		if keep_one:
			start_file.write('keep_one ')
		if post_frag:
			start_file.write('post_frag ')

		start_file.write('\n')

		start_file.write('cp ' +  i[:-4] + '_taut.smi $PBS_O_WORKDIR')

		start_file.close()
		os.system('chmod 744 '  + file_name)
		command = 'qsub -V -q short ' + file_name
		print command
		os.system(command)





