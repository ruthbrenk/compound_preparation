#!/usr/bin/python
#match smarts, based on OE's match.py
#get smarts from db

import os,sys,string
from openeye.oechem import *
import chemistry


smiles_file=oemolistream()
smiles_file.open(sys.argv[1])
out_file=open(sys.argv[2],'w') 

if len(sys.argv) ==4:
	table = 'definition_reactive_warhead'

else:
	table = 'definition_unwanted_groups_openeye'

print 'Using', table


#--------------------------------------------
def header_line(out_file, smarts_list):
  old_label = ''
  out_file.write('identifier')
  for i in smarts_list:
   if i[1] <> old_label:
     out_file.write('\t' + i[1])
     old_label = i[1]
  out_file.write('\n')
    

#############################################################################
if __name__=='__main__':
  print 'filter smiles'	

  #some options from the original match.py file
  usa=1; asym=1; exph=0; max=0; smartsfile=None; verbose=0;
  qmolfile=None; kekule=0; atom_expr=None; bond_expr=None;
  smartslist=None; qmollist=None; nowarn=0;
  
  smarts_list=chemistry.get_smartslist(table)

  patlist= chemistry.get_patlist(smarts_list, atom_expr, bond_expr,max)

  header_line(out_file,smarts_list)
  
  for mol in smiles_file.GetOEMols():
    chemistry.CanSmi(mol,True, False, True) #this line is crucial because it calls a bunch of standardization routines which will influence the smarts matching
    #print chemistry.CanSmi(mol,True, False, True)
    hit_list =[]
    old_description = ''
    for pat,smarts,description in patlist:

      #print smarts, description
      matchcount=chemistry.Match(pat,smarts,mol,kekule,verbose,exph,asym,usa)
      #print matchcount	
      if description <> old_description:
        if matchcount > 0:
           hit_list.append('y')
        else:
           hit_list.append('')
        old_description = description
      else:
        if matchcount > 0:
           hit_list[len(hit_list)-1] = 'y'
    if 'y' in hit_list:
      out_file.write(mol.GetTitle())
      for i in hit_list:
        out_file.write('\t' + i)
      out_file.write('\n')

out_file.close()
smiles_file.close()
print 'done'

