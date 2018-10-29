#!/usr/bin/python
#match smarts, based on OE's match.py
#file with smiles, file with smarts (smarts, tab, description, tab whatever), new file
import os,sys,string
import my_mysql as mysql
from openeye.oechem import *
import chemistry
import MySQLdb

smiles_file=oemolistream()
smiles_file.open(sys.argv[1])
out_file=open(sys.argv[2],'w') 



#--------------------------------------------
def header_line(out_file, smarts_list):
  old_label = ''
  out_file.write('identifier')
  for i in smarts_list:
   if i[1] <> old_label:
     out_file.write('\t' + i[1])
     old_label = i[1]
  out_file.write('\n')
    

#--------------------------------------------
if __name__=='__main__':
  print 'filter smiles'	

  #some options from the original match.py file
  usa=1; asym=1; exph=0; max=0; smartsfile=None; verbose=0;
  qmolfile=None; kekule=0; atom_expr=None; bond_expr=None;
  smartslist=None; qmollist=None; nowarn=0;
  
  smarts_list=chemistry.get_smartslist('definition_count_groups_openeye')

  patlist= chemistry.get_patlist(smarts_list, atom_expr, bond_expr,max)
  
  header_line(out_file,smarts_list)
  
  for mol in smiles_file.GetOEMols():
    hit_list =[]
    old_description = ''
    changed = False
    for pat,smarts,description in patlist:
      
      matchcount=chemistry.Match(pat,smarts,mol,kekule,verbose,exph,asym,usa)
      #print matchcount	
      if description <> old_description:
        if matchcount > 0:
           hit_list.append(matchcount)	
	   changed = True
        else:
           hit_list.append(0)
        old_description = description
      else:
        if matchcount > 0:
           hit_list[len(hit_list)-1] = matchcount + hit_list[len(hit_list)-1]
	   changed = True
    if changed:
      changed = False	
      out_file.write(mol.GetTitle())
      for i in hit_list:
        out_file.write('\t' + str(i))
      out_file.write('\n')

out_file.close()
smiles_file.close()
print 'finished'

