#!/usr/bin/python

#neutralize charged groups and remember, if it was a base or an acid
#get neutralize rules from database, check if applicable for the molecule => record what happend

from openeye.oechem import *
import chemistry
import sys, string, re

#-----------
if len(sys.argv) <> 4:
	print 'neutralize_charged_cpds_for_clopg.py  <input_file> <output_file.smi> <output_data.txt>'
	sys.exit(1)

debug = False
ifs = oemolistream(sys.argv[1])
smiles_file = open(sys.argv[2], 'w')
data_file = open(sys.argv[3], 'w')

if debug:
	charged_molis = open('charged.smi', 'w')


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
mol = OEGraphMol()

iso = True #keep stereoinformation
kek = False #kekulize to get unique smiles (no, this is no longer true)
chiral = True #keep information about chirality (could also be false, because this information is guessed anyway)

#some options from the original match.py file
usa=1; asym=1; exph=0; max=0; smartsfile=None; verbose=0;
qmolfile=None; kekule=0; atom_expr=None; bond_expr=None;
smartslist=None; qmollist=None; nowarn=0;


reaction = 0
type = 1
pka =2
comment = 3

rules = chemistry.neutralize_get_rules()

#print rules

#header for data file
data_file.write('id\tcharge')
for rule in rules:
	data_file.write('\t' + str(rule[pka]))
data_file.write('\n')

while OEReadMolecule(ifs, mol):

  #remove spaces in title
  title = mol.GetTitle()
  mol.SetTitle(title.replace(' ', ''))
  
  OE3DToInternalStereo(mol)
  OEFindRingAtomsAndBonds(mol)
  OEAssignAromaticFlags(mol)
  OEAssignFormalCharges(mol)
  smiles_list = [chemistry.CanSmi(mol,iso,kek,chiral)]
  match_list = []
  for rule in rules:
    #print rule
    tmp_list = []
    #tmp_list_kek = []	#only for kekulized smiles unique thing works
    for smiles in smiles_list:
	#apply rules
	#print smiles
	old_smi = smiles
	for transformation in rule[0]:
		#check if transformation can be applied to compound
		smarts, junk = transformation.split('>>')
	        pat=OESubSearch()
      		if not pat.Init(re.sub('\s.*$','',smarts)):
        		OEThrow.Fatal('Bad smarts: '+smarts)

      		if atom_expr>=0 or bond_expr>=0:
        		if not atom_expr>=0: atom_expr=OEExprOpts_DefaultAtoms
        		if not bond_expr>=0: bond_expr=OEExprOpts_DefaultBonds
        		qmol=pat.GetPattern()
        		qmol.BuildExpressions(atom_expr,bond_expr)
        		pat=OESubSearch(qmol)

		matchcount=chemistry.Match(pat,smarts,mol,kekule,verbose,exph,asym,usa)
		match_list.append(matchcount)   
 


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
	#create a molecule
	work_mol = OEGraphMol()
	OEParseSmiles(work_mol, moli)
	OEAssignImplicitHydrogens(work_mol)
	OEFormalPartialCharges(work_mol)
	total_charge = 0.0
	for atom in work_mol.GetAtoms():
		total_charge = total_charge + atom.GetPartialCharge()
	data_file.write(mol.GetTitle() + '\t' + str(total_charge))
	smiles_file.write(smi_not_kek + '\t' + mol.GetTitle() + '\n')
	if debug and total_charge <> 0.0:
		charged_molis.write(smi_not_kek + '\t' + mol.GetTitle() + '\n')
	for match in match_list:
		data_file.write('\t' + str(match))
	data_file.write('\n')

data_file.close()
smiles_file.close()
if debug:
	charged_molis.close()

