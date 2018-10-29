#!/usr/bin/python

from openeye.oechem import *
import chemistry
import my_mysql as mysql
import sys, string

#-----------
if len(sys.argv) < 3 or len(sys.argv) > 6:
	print 'tautomerizer.py  <input_file> <output_file.smi> <debug (optional)> <keep_one (optional)> <post_frag (optional)>'
	sys.exit(1)


debug = False
keep_one = False
post_frag = False
if len(sys.argv) >= 4:
	if sys.argv[3] == 'debug':
		debug = True
	elif sys.argv[3] == 'keep_one':
		keep_one = True
	elif sys.argv[3] == 'post_frag':
		post_frag = True
	if len(sys.argv) >= 5:
		if sys.argv[4] == 'debug':
			debug = True
		elif sys.argv[4] == 'keep_one':
			keep_one = True
		elif sys.argv[4] == 'post_frag':
			post_frag = True		
	if len(sys.argv) == 6:
		if sys.argv[5] == 'debug':
			debug = True
		elif sys.argv[5] == 'keep_one':
			keep_one = True
		elif sys.argv[5] == 'post_frag':
			post_frag = True
					
if debug:
	print 'DEBUG mode'
	test_file =open(sys.argv[2][:-4] + '_taut_test.smi', 'w')
ifs = oemolistream(sys.argv[1])
out_file = open(sys.argv[2], 'w')




#------------------------------rule[equi] == 0--------------
def read_rules():
	conn=mysql.connect2server('', 'webuser','purchasable')  			  
	cursor = conn.cursor ()
	command = "SELECT smirks, direction, type, comment, id, kek, known_error_string FROM definition_tautomer_rules order by id"
	cursor.execute(command)
	rows = cursor.fetchall ()

	rules = []
	for row in rows:
			if row[2] == 'equal':
				equal = True
			elif row[2] == 'unequal':
				equal = False
			else:
				print 'typo'
  			rules.append([[row[0]],float(row[1]),equal,row[3],row[5],row[6]])
	cursor.close()
	conn.close()
  	return rules
#--------------------------------------------
def reformat_rules(rules):
  #OPENEYE has got a problem with writting [NH3+], ...
  rule_counter = 0
  for rule in rules:
	trans_counter = 0
	for transformation in rule[0]:
		educt, product = transformation.split('>>')
		#primary amines
		product = product.replace('[NH3+]', '[N+]([H])([H])[H]')
		#secundary amines
		product = product.replace('[NH2+]', '[N+]([H])([H])')
		#tertary amines
		product = product.replace('[NH+]', '[N+]([H])')
		product = product.replace('[nH+]', '[n+]([H])')
		product = product.replace('[nH]', '[n]([H])')
		#educt = educt.replace('([H])','')
		reaction = educt + '>>' + product
		#print reaction
		rules[rule_counter][0][trans_counter] = reaction
		trans_counter = trans_counter + 1
	rule_counter = rule_counter + 1
  return rules
#--------------------------------------------
def fix_bonds (smiles,debug):
#openeye does not write to write [NH3+], ... => backward reaction does not work
	old_smiles = smiles

	#fix double bond
    	smiles = smiles.replace('c(=c','c(c')
    	smiles = smiles.replace('c1=c','c1c')
    	smiles = smiles.replace('c=c','cc')
    	smiles = smiles.replace('=c[n','c[n')
    	smiles = smiles.replace('c=n','cn')
    	smiles = smiles.replace('n=c','nc')
    	smiles = smiles.replace('c=[n','c[n')

	if debug and old_smiles <> smiles:
		print 'cleaned smiles: '  + old_smiles + ' -> '+ smiles 
		print
	

	return smiles
#--------------------------------------------
def check_smi(org_smiles, smi,old_smi, rule, comment, title, error_string, debug):
   error = False
   if (smi.find('.') <> -1  or smi.find('[C]') <> -1 or smi.find('[CH]') <> -1  or smi.find('[c]') <> -1 or smi.find('[C+]') <> -1  or smi.find('[N]') <> -1 or smi.find('[n]') <> -1) and smi <> org_smiles:
	error_string = error_string.replace(' ', '')
	error_list = error_string.split(',')
	for error_string in error_list:
		if smi.find(error_string) <> -1 and smi.find(error_string) <> 0: #this is  known issue which the user has not to worry about (0 for empty fields)
			error = True #resulting smiles is wrong but do not display error message
	if not error:
     		print '----> error <------'
     		print rule+', '+  comment+', '+  title
     		print smi
     		error = True
   if debug and smi <> old_smi:
      print'----> reaction <------'	
      print old_smi
      print '--> ' + title  +', '+ rule +', ' + comment
      print smi
      print '----> end <------'
      print
   return error
#--------------------------------------------
#-----------------------
mol = OEGraphMol()

iso = True #keep stereoinformation
kek = False #kekulize to get unique smiles (no, this is no longer true)
chiral = True #keep information about chirality (could also be false, because this information is guessed anyway)

reaction = 0
equi =1
equal = 2
comment = 3
kekulize = 4
error_string = 5

rules = read_rules()

#check if forward or backward reactions
counter = 0
for rule in rules:
    #print rule[equi], unique
    #0: only nitrogens involved (e. g. imidazole) => a unique string can not be generated
    #1: always only one form wanted
    if rule[equi] == 0:
	direction = 'both'
    else:
	direction = 'forward'

    #print direction
    #for some reactions 'both' simply means to keep the input string, the backward reaction would result in the input string again anyway
    if direction == 'both' and not rule[equal]:
	start = rule[reaction][0].find('>')
	backward_direction = rule[reaction][0][start+2:] +  '>>' + rule[reaction][0][:start]
  	rules[counter][reaction].append(backward_direction)
	#print 'test', rules[counter][reaction]
    counter = counter + 1

rules = reformat_rules(rules)


while OEReadMolecule(ifs, mol):
  OE3DToInternalStereo(mol)
  OEFindRingAtomsAndBonds(mol)
  OEAssignAromaticFlags(mol)
  OEAssignFormalCharges(mol)
  smiles_list = [chemistry.CanSmi(mol,iso,kek,chiral)]
  #molis = []
  for rule in rules:
    #print rule
    tmp_list = []
    for smiles in smiles_list:
	#apply rules
	#print smiles
	old_smi = smiles
	for transformation in rule[0]:
		#print transformation
		#if 0 => keep always both smiles 
		if rule[equi] == 0 and smiles not in tmp_list:
			tmp_list.append(smiles)
			#print 'test', transformation	
		#make mol
		work_mol = OEGraphMol()
		if rule[kekulize]:
			#some rules with fused rings work better if smiles are kekulized
			OEParseSmiles(work_mol, smiles)
			smiles = chemistry.CanSmi(work_mol,iso,True, chiral)
			work_mol = OEGraphMol() #destroy work_mol
			#print smiles, '================+++++'
			
		OEParseSmiles(work_mol, smiles)
		OEAddExplicitHydrogens(work_mol) #otherwise OE will complain for rules with explicit hydrogen atoms
   		umr = OEUniMolecularRxn(transformation)
    		umr(work_mol)
		
		smi = chemistry.CanSmi(work_mol,iso,kek, chiral)
		error = check_smi(smiles, smi, old_smi, transformation, rule[comment], mol.GetTitle(), rule[error_string], debug)
		if smi not in tmp_list and not error:
			tmp_list.append(smi)
		elif error:
			if old_smi not in tmp_list:
				#otherwise smiles would get lost
				tmp_list.append(old_smi)
		#if kekulized smiles -> generate normal smiles for next round
		if rule[kekulize]:
			work_mol = OEGraphMol()
			OEParseSmiles(work_mol, smiles)
			smiles = chemistry.CanSmi(work_mol,iso,kek, chiral)
    #update smiles_list
    smiles_list = []
    for i in tmp_list:
	smiles_list.append(i)
    #if debug:
	#print smiles_list

  
  if debug:
	print 'results: ', smiles_list
	
  if post_frag:
    tau='A'
    for moli in smiles_list:
	if len(smiles_list) == 1:
		smi_not_kek = chemistry.clean_smiles(moli)
		out_file.write(smi_not_kek + '\t' + mol.GetTitle() + '\n')
		if debug: print smi_not_kek + '\t' + mol.GetTitle() + '\n'
	elif len(smiles_list) > 1:
		smi_not_kek = chemistry.clean_smiles(moli)
		out_file.write(smi_not_kek + '\t' + tau + mol.GetTitle() + '\n')
		if debug: smi_not_kek + '\t' + tau + mol.GetTitle() + '\n'
		if tau == 'A':
			tau = 'B'
		elif tau == 'B':
			tau = 'C'
		elif tau == 'C':
			tau = 'D'
  else: #not post_frag mode
    for moli in smiles_list:

	smi_not_kek = chemistry.clean_smiles(moli)
	out_file.write(smi_not_kek + '\t' + mol.GetTitle() + '\n')
	if debug and len(smiles_list) > 1:
		test_file.write(smi_not_kek + '\t' + mol.GetTitle() + '\n')
	if keep_one:
		break #only keep one tautomer per moli
		

if debug:
	test_file.close()

print 'finished tautomerizer'

