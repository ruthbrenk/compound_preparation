#!/usr/bin/env python

#file with smiles, file with smirks, out_file
#range = 0 -> only one form per compound
#does not check stereo chemistry -> is not defined in Chemdiv files -> best to make the guesses after charging and tautomerizing the molecules
#if 3D input files -> stereo chemistry is kept
#if unique smile => has to be kekulised (no, that is not anylonger true, I fixed the "unique smiles" converter)
#this scripts also removes smaller fragments in complexes ("desalt")

from openeye.oechem import *
import chemistry
import my_mysql as mysql
import sys, string

#-----------
if len(sys.argv) < 7 or len(sys.argv) > 8:
	print 'charger.py  <input_file> <output_file.smi> <Charge molecule:True|False> <pH> <ph range> <Supplier Id numer field> > <debug (optional)>'
	sys.exit(1)

debug = False


if len(sys.argv) == 8:
	if sys.argv[7] == 'debug':
		debug = True	

ifs = oemolistream(sys.argv[1])
#rules_file = open(sys.argv[2], 'r')
out_file = open(sys.argv[2], 'w')
charge = sys.argv[3]
ph = float(sys.argv[4])
ph_range = float(sys.argv[5])
code = sys.argv[6]

#print charge, ph_range


#--------------------------------------------
def get_rules():
	cursor = conn.cursor ()
	command = "SELECT smirks, type, pka, comment, id FROM definition_prot_rules order by id"
	cursor.execute(command)
	rows = cursor.fetchall ()

	rules = []
	for row in rows:
		rules.append([[row[0]],row[1],float(row[2]),row[3]])
	
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
#------
conn=mysql.connect2server('', 'webuser','purchasable')  	

print 'text'
print 'if mol2 file is used as input file only molecules with name "LIM...." while be keept. If you want to keep also other files you have to modify lines 153-154'		  

mol = OEGraphMol()

iso = True #keep stereoinformation
kek = False #kekulize to get unique smiles (no, this is no longer true)
chiral = True #keep information about chirality (could also be false, because this information is guessed anyway)

reaction = 0
type = 1
pka =2
comment = 3

#rules = read_rules(rules_file)
rules = get_rules()

#check if forward or backward reactions
counter = 0
for rule in rules:
    #print rule
    if (rule[type] == 'acid'):
	#if range =0 -> only one reaction
	if (rule[pka] < (ph - ph_range)) or (ph_range == 0 and rule[pka] <= (ph - ph_range)):
		direction = 'forward'
	elif rule[pka] > (ph + ph_range):
		direction = 'backwards'
	else:
		direction = 'both'
    else:
	if (rule[pka] > (ph + ph_range)) :
		direction = 'forward'
	elif rule[pka] < (ph - ph_range) or (ph_range == 0 and rule[pka] >= (ph + ph_range)):
		direction = 'backwards'
	else:
		direction = 'both'

    #print direction
    if direction <> 'forward':
	#print rule[reaction][0]
	start = rule[reaction][0].find('>')
	backward_direction = rule[reaction][0][start+2:] +  '>>' + rule[reaction][0][:start]
    if direction == 'backwards':
    	rules[counter][reaction][0] = backward_direction
    elif direction == 'both':
    	rules[counter][reaction].append(backward_direction)
	#print 'test', rules[counter][reaction]
    counter = counter + 1

rules = reformat_rules(rules)

#print rules

while OEReadMolecule(ifs, mol):
  #print mol.GetTitle()
  if OEHasSDData(mol, code):
	mol.SetTitle(OEGetSDData(mol, code))
  elif sys.argv[1][-4:] == '.sdf':
	print 'SD field does not exist'
  #remove spaces in title
  title = mol.GetTitle()
  mol.SetTitle(title.replace(' ', ''))

  #for mol2 files check if molecule name contains LIM (useful to delete protein and water entries from Relibase downloads)
  if sys.argv[1][-4:] == 'mol2' and title.find('LIM') == -1:
	continue #not a ligand -> nothing to do with this molecule -> go on with next molecule in while loop
  
  OETheFunctionFormerlyKnownAsStripSalts(mol)
  OE3DToInternalStereo(mol)
  OEFindRingAtomsAndBonds(mol)
  OEAssignAromaticFlags(mol)
  OEAssignFormalCharges(mol)
  smiles_list = [chemistry.CanSmi(mol,iso,kek,chiral)]
  #print smiles_list
  for rule in rules:
    #print rule
    tmp_list = []
    #tmp_list_kek = []	#only for kekulized simles unique thing works
    for smiles in smiles_list:
	#apply rules
	#print smiles
	old_smi = smiles
	for transformation in rule[0]:
		#make mol
		work_mol = OEGraphMol()
		OEParseSmiles(work_mol, smiles)
   		umr = OEUniMolecularRxn(transformation)
    		umr(work_mol)
		smi = chemistry.CanSmi(work_mol,iso,kek, chiral)
		error = chemistry.check_smi(smi, old_smi, transformation, rule[comment], mol.GetTitle(), debug)
		#smi_kek = chemistry.CanSmi(work_mol,iso,True,chiral)
		if smi not in tmp_list and not error:
			tmp_list.append(smi)
			#tmp_list_kek.append(smi_kek)
		elif error:
			if old_smi not in tmp_list:
				#otherwise smiles would get lost
				tmp_list.append(old_smi)
    #update smiles_list
    smiles_list = []
    for i in tmp_list:
	smiles_list.append(i)

  
  if debug:
	print 'results'
  	print smiles_list
  
  for moli in smiles_list:

	smi_not_kek = chemistry.clean_smiles(moli)
	if charge == 'True':
		#create a molecule
		work_mol = OEGraphMol()
		OEParseSmiles(work_mol, moli)
		OEAssignImplicitHydrogens(work_mol)
    		OEFormalPartialCharges(work_mol)
    		total_charge = 0.0
    		for atom in work_mol.GetAtoms():
   			total_charge = total_charge + atom.GetPartialCharge()
		if debug:
			print 'charge: ' + str(total_charge)
		out_file.write(smi_not_kek + '\t' + mol.GetTitle() + '\t' + str(total_charge) + '\n')
	else:
		out_file.write(smi_not_kek + '\t' + mol.GetTitle() + '\n')
	
	

print 'finished charger'

