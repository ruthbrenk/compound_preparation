#!/usr/bin/env python
#derive mw, #Heavyatoms, #atoms not in ring, HBD, HBA, Rotbonds, #Rings, total charge, partially charged groups
#donor: every N or O with H attached => NH2 = 1 donor
#acceptor: every N or O without H and not 5 valences (this rule excludes N of NO2) => NO2 - 2 accptors, carboxylate -> 2 acceptors; amid n are also counted as acceptors
#atom can only be either a donor or an acceptor
#large ring system: 3 or more fused rings
#adamantane type: 10 atome, 3 rings

#file with smiles, new file
import os,sys,string,re
from openeye.oechem import *
from openeye.oemolprop import *
from openeye.oequacpac import *


smiles_file=oemolistream(sys.argv[1])
out_file=open(sys.argv[2],'w') 

#--------------------------------------------
def get_heavy_atoms(mol):
  hev_at = 0
  not_ring_atoms = 0
  for atom in mol.GetAtoms(OEIsHeavy()):
      hev_at = hev_at + 1 
      if not atom.IsInRing():
	not_ring_atoms = not_ring_atoms + 1
     
  return hev_at, not_ring_atoms
#--------------------------------------------
def get_donor_acceptor(mol): #modified 02/05 -> group can be donor and acceptor
  # only check non-carbon atoms
  donor = 0
  acceptor = 0
  #hydrogens have to be explicitly here
  OEAddExplicitHydrogens(mol)
  for atom in mol.GetAtoms(OEIsPolar()):
      if atom.IsNitrogen() or atom.IsOxygen():
        hydrogen = False
	amid = False
	n_pl3_ring = False
        for nbor in atom.GetAtoms():
 	   if OEGetAtomicSymbol(nbor.GetAtomicNum()) == 'H':
              hydrogen = True
        if hydrogen:
          donor = donor + 1
        if atom.GetValence() <> 5 and atom.GetPartialCharge() <=0 : #otherwithse it is a nitro-group nitrogen or positively charged -> is not an acceptor
		#exclude amids as acceptors
		if atom.IsNitrogen():
			not_h_count = 0
			for nbor in atom.GetAtoms():
				if OEGetAtomicSymbol(nbor.GetAtomicNum()) == 'C':
					for nbor2 in nbor.GetAtoms():
						if OEGetAtomicSymbol(nbor2.GetAtomicNum()) == 'O':
							for bonds in nbor2.GetBonds():
								if bonds.GetOrder() == 2:
									amid = True

				if OEGetAtomicSymbol(nbor.GetAtomicNum()) <> 'H':
					not_h_count = not_h_count + 1
			if not_h_count == 3 and atom.IsAromatic() and atom.IsInRing():
				n_pl3_ring = True
	        if not amid and not n_pl3_ring:
			acceptor = acceptor + 1
    
  return donor, acceptor
#--------------------------------------------
#--------------------------------------------
def get_donor_acceptor_old(mol): #that's how it was done for the original paper
  # only check non-carbon atoms
  donor = 0
  acceptor = 0
  #hydrogens have to be explicitly here
  OEAddExplicitHydrogens(mol)
  for atom in mol.GetAtoms(OEIsPolar()):
      if atom.IsNitrogen() or atom.IsOxygen():
        hydrogen = False
	amid = False
	n_pl3_ring = False
        for nbor in atom.GetAtoms():
 	   if OEGetAtomicSymbol(nbor.GetAtomicNum()) == 'H':
              hydrogen = True
        if hydrogen:
          donor = donor + 1
        elif atom.GetValence() <> 5 and atom.GetPartialCharge() <=0 : #otherwithse it is a nitro-group nitrogen or positively charged -> is not an acceptor
		#exclude amids as acceptors
		if atom.IsNitrogen():
			not_h_count = 0
			for nbor in atom.GetAtoms():
				if OEGetAtomicSymbol(nbor.GetAtomicNum()) == 'C':
					for nbor2 in nbor.GetAtoms():
						if OEGetAtomicSymbol(nbor2.GetAtomicNum()) == 'O':
							for bonds in nbor2.GetBonds():
								if bonds.GetOrder() == 2:
									amid = True

				if OEGetAtomicSymbol(nbor.GetAtomicNum()) <> 'H':
					not_h_count = not_h_count + 1
			if not_h_count == 3 and atom.IsAromatic() and atom.IsInRing():
				n_pl3_ring = True
	        if not amid and not n_pl3_ring:
			acceptor = acceptor + 1
    
  return donor, acceptor
#--------------------------------------------
def get_rotors(mol):
  rotors = 0
  for bond in mol.GetBonds():
     if bond.IsRotor():
       rotors = rotors + 1   
  return rotors
#--------------------------------------------
def cal_charge(mol):
  charge = 0
  partial_charged = False

  for atom in mol.GetAtoms():
    partial_charge = atom.GetPartialCharge()
    charge = charge + partial_charge
    if (partial_charge <> 0) and not partial_charged:
       partial_charged = True
  
  charge = round(charge,0)
  if charge == -0:
    charge = 0
  charge = int(charge)
  return charge, partial_charged
#-------------------------------
def get_large_fused_ring_system(ringlist,rings,mol):
  #three or more fused rings
    large_system = False
    max = 12
    pred = OEPartPredAtom(ringlist)
    for i in range(1,rings + 1):
        pred.SelectPart(i)
        partmol = OEGraphMol()
        OESubsetMol(partmol, mol, pred)
	OEFindRingAtomsAndBonds(partmol)
	fused_atoms = 0
	if not large_system:
	  for atom in partmol.GetAtoms():
		neighbours = atom.GetHvyDegree()
		if neighbours >= 3:
			#fusing atom
			fused_atoms = fused_atoms + 1
			#check if one of the neighbours is also a fusing atom
			connected = False
			for neighbour_at in atom.GetAtoms():
				neighbours = neighbour_at.GetHvyDegree()
				if neighbours >=3:
					#two fusing atoms are connected
					connected = True
			if not connected:
				# "strange" ringsystem, exclude them
				fused_atoms = fused_atoms + 1
			
	  if fused_atoms > 2:
		#large system
    		large_system = True

    return large_system
#-------------------------------
def XlogP(mol):
    OERemoveFormalCharge(mol)		
    avals = OEFloatArray(mol.GetMaxAtomIdx())
    try:
    	logp = OEGetXLogP(mol, avals)
    except:
	logp =9999
    

    return logp
#-------------------------------
def frac_csp3(mol):
    fcsp3 =OEGetFractionCsp3(mol)

    return fcsp3
#-------------------------------
#############################################################################
if __name__=='__main__':
  print 'Calculating descriptors'

  #out_file.write('identifier\t' + 'MW\t' + 'hev_atoms\t' + 'donors\t' + 'acceptors\t' + 'rot_bonds\t' + 'ring_systems\t' + 'not_ring_atoms\t' + 'fused_rings\t' + 'total_charge\t' + 'partial_charged\n')  

  out_file.write('identifier\t' + 'MW\t' + 'hev_atoms\t' + 'donors\t' + 'acceptors\t' + 'rot_bonds\t' + 'ring_systems\t' + 'not_ring_atoms\t' + 'fused_rings\t' + 'total_charge\t' + 'XlogP\t'+ 'fCSp3\n') 
  for mol in smiles_file.GetOEMols():
     #the following lines were missing when processing the ChemDiv files
     OEFindRingAtomsAndBonds(mol)
     OEAssignAromaticFlags(mol)

     mw = OECalculateMolecularWeight(mol)
     hev_at, not_ring_atoms = get_heavy_atoms(mol)
     OEFormalPartialCharges(mol)
     charge,partial_charges = cal_charge(mol)
     donor, acceptor = get_donor_acceptor(mol)
     rot_bonds =get_rotors(mol)
     OEAssignImplicitHydrogens(mol)	
     rings, ringlist = OEDetermineRingSystems(mol)
     large_fused_ring = get_large_fused_ring_system(ringlist,rings,mol)
     logp = XlogP(mol)
     fcsp3 = frac_csp3(mol)
     out_file.write(mol.GetTitle() + '\t' + '%.2f'%mw + '\t' + str(hev_at) + '\t' + str(donor) + '\t' + str(acceptor) + '\t' + str(rot_bonds) + '\t' + str(rings) + '\t' + str(not_ring_atoms) + '\t' + str(large_fused_ring) + '\t' +  str(charge) + '\t' +  str(logp)+ '\t' +  str(fcsp3)+ '\n')


out_file.close()
smiles_file.close()
print 'done'

