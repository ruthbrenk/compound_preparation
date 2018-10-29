#!/usr/bin/python
#############################################################################
#  Copyright (C) 2003, 2004 OpenEye Scientific Software, Inc.
#############################################################################
#
#############################################################################
#  tpsa.py 
#############################################################################
#  (Ported from Peter Ertl's public domain Daylight contrib C source code,
#  with S/P handling according to the publication.)
#############################################################################
#
#  Calculation of polar surface area based on fragment contributions (TPSA)
#  Peter Ertl, Novartis Pharma AG, Basel, August 2000
#  peter.ertl@pharma.novartis.com || peter.ertl@altavista.net
#
#  For description of the methodology see:
#  P. Ertl, B. Rohde, P. Selzer,
#  Fast Calculation of Molecular Polar Surface Area as a Sum of Fragment-based
#  Contributions and Its Application to the Prediction of Drug Transport 
#  Properties, J.Med.Chem. 43, 3714-3717, 2000
#
#  The program expects "problematic" nitrogens in pentavalent form, i.e. nitro 
#  groups as -N(=O)=O, N-oxides as c1ccccn1=O, and azides as -N=N#N.  
#
#############################################################################
import sys,os,getopt
from openeye.oechem import *


#############################################################################
def CalcPSA(mol,SandP):
  psa = 0.0
  for atom in mol.GetAtoms():
    an = atom.GetAtomicNum()
    if SandP and an!=8 and an!=7 and an!=15 and an!=16:
      continue	### O/N/S/P only
    elif an!=8 and an!=7:
      continue	### O/N only
    nh = atom.GetTotalHCount()
    q = atom.GetFormalCharge()
    # isarom = atom.IsAromatic()	### not used
    in3ring = OEAtomIsInRingSize(atom,3)

    nv = 0	### number of neighbours
    ##	finding the number of -,=,#,: bonds originating from the atom
    n1 = 0; n2 = 0; n3 = 0; narom = 0;

    for bond in atom.GetBonds():
      nv+=1
      bt = bond.GetIntType()
      if bt==1: n1+=1		# single
      elif bt==2: n2+=1		# double
      elif bt==3: n3+=1		# triple
      elif bt==5: narom+=1	# aromatic

    ##	finding the psa contribution for this fragment (atom with hydrogens)
    p = -1.0
    if an==7:	# Nitrogen
      if nv==1:
        if (nh==0 and n3==1 and q==0): p=23.79; # N#
        elif (nh==1 and n2==1 and q==0): p=23.85; # [NH]=
        elif (nh==2 and n1==1 and q==0): p=26.02; # [NH2]-
        elif (nh==2 and n2==1 and q==1): p=25.59; # [NH2+]=
        elif (nh==3 and n1==1 and q==1): p=27.64; # [NH3+]-

      elif nv==2:
        if (nh==0 and n1==1 and n2==1 and q==0): p=12.36; # =N-
        elif (nh==0 and n3==1 and n2==1 and q==0): p=13.60; # =N#
        elif (nh==1 and n1==2 and q==0 and not in3ring): p=12.03; # -[NH]-
        elif (nh==1 and n1==2 and q==0 and in3ring): p=21.94; # -[NH]-r3
        elif (nh==0 and n3==1 and n1==1 and q==1): p=4.36; # -[N+]#
        elif (nh==1 and n2==1 and n1==1 and q==1): p=13.97; # -[NH+]=
        elif (nh==2 and n1==2 and q==1): p=16.61; # -[NH2+]-
        elif (nh==0 and narom==2 and q==0): p=12.89; # :[n]:
        elif (nh==1 and narom==2 and q==0): p=15.79; # :[nH]:
        elif (nh==1 and narom==2 and q==1): p=14.14; # :[nH+]:

      elif nv==3:
        if (nh==0 and n1==3 and q==0 and not in3ring): p=3.24; # -N(-)-
        elif (nh==0 and n1==3 and q==0 and in3ring): p=3.01; # -N(-)-r3
        elif (nh==0 and n1==1 and n2==2 and q==0): p=11.68; # -N(=)=
        elif (nh==0 and n1==2 and n2==1 and q==1): p=3.01; # =[N+](-)-
        elif (nh==1 and n1==3 and q==1): p=4.44; # -[NH+](-)-
        elif (nh==0 and narom==3 and q==0): p=4.41; # :[n](:):
        elif (nh==0 and n1==1 and narom==2 and q==0): p=4.93; # -:[n](:):
        elif (nh==0 and n2==1 and narom==2 and q==0): p=8.39; # =:[n](:):
        elif (nh==0 and narom==3 and q==1): p=4.10; # :[n+](:):
        elif (nh==0 and n1==1 and narom==2 and q==1): p=3.88; # -:[n+](:):

      elif nv==4:
        if (nh==0 and n1==4 and q==1): p=0.00; # -[N+](-)(-)-

      if p<0.0:	# N with non-standard valency
        p = 30.5 - nv * 8.2 + nh * 1.5
        if p<0.0: p=0.0

    elif an==8:	# Oxygen
      if nv==1:
        if (nh==0 and n2==1 and q==0): p=17.07; # O=
        elif (nh==1 and n1==1 and q==0): p=20.23; # [OH]-
        elif (nh==0 and n1==1 and q==-1): p=23.06; # [O-]-

      elif nv==2:
        if (nh==0 and n1==2 and q==0 and not in3ring): p=9.23; # -O-
        elif (nh==0 and n1==2 and q==0 and in3ring): p=12.53; # -O-r3
        elif (nh==0 and narom==2 and q==0): p=13.14; # :o:

      if p<0.0:	# O with non-standard valency
        p = 28.5 - nv * 8.6 + nh * 1.5
        if p<0.0: p=0.0

    elif an==15:	# Phosphorus
      if narom>0: p=0.0
      elif (nv==2 and n1==1 and n2==1): p=34.14 # [P](-*)=*
      elif (nv==3 and n1==2 and n2==1): p=23.47 # [P](=*)(-*)-*
      elif (nv==3 and n1==3): p=13.59 # [P](-*)(-*)-*
      elif (nv==4 and n1==3 and n2==1): p=9.81; # [P](-*)(-*)(-*)=*

    elif an==16:	# Sulphur
      if (nv==2 and narom==2): p=28.24 # [s](:*):*
      elif (nv==2 and n1==2): p=25.30 # [S](-*)-*
      elif (nv==3 and narom==2 and n2==1): p=21.70 # [s](:*)(:*)=*
      elif (nv==3 and n1==2 and n2==1): p=19.21 # [S](-*)(-*)=*
      elif (nv==4 and n1==2 and n2==2): p=8.38 # [S](-*)(-*)(=*)=*



    psa += p

  return psa



#############################################################################
if __name__=='__main__':
  PROG=os.path.basename(sys.argv[0])
  usage='''
    %(PROG)s [options] [<infile]
        options:
           --h  ... help
           --i=<infile>
           --ifmt=<FMT>
           --o=<infile>
           --ofmt=<FMT>
           --SandP ... handle Sulphur and Phosphorus (published algorithm)
           --titleout true|false ... append tpsa to title [default=true]
           --sdout true|false ... output tpsa as SD datum [default=true]
  '''%{'PROG':PROG}
  
  ifmt=0; ofmt=0; wegot_ifile=0; wegot_ofile=0; titleout=1; sdout=1;
  SandP=0;
  ims=oemolistream()
  oms=oemolostream()
   
  opts,pargs=getopt.getopt(sys.argv[1:],'h',['h','i=','ifmt=',
    'o=','ofmt=','titleout=','sdout=','SandP'])
  
  for opt,val in opts:
    if opt=='--h': OEThrow.Usage(usage)
    elif opt=='--i':
      if not ims.open(val): OEThrow.Fatal('Cannot open: %s' % val)
      wegot_ifile=1
    elif opt=='--ifmt':
      ifmt=globals()['OEFormat_'+val.upper()]
      ims.SetFormat(ifmt)
    elif opt=='--o':
      if not oms.open(val): OEThrow.Fatal('Cannot open: %s' % val)
      wegot_ofile=1
    elif opt=='--ofmt':
      ofmt=globals()['OEFormat_'+val.upper()]
      oms.SetFormat(ofmt)
    elif opt=='--SandP':
      SandP=1
    elif opt=='--titleout':
      if val=='false': titleout=0
    elif opt=='--sdout':
      if val=='false': sdout=0
    else: OEThrow.Fatal('Illegal option: %s\n%s' % (opt,usage))
  
  if not wegot_ifile and not ifmt:
    OEThrow.Fatal('Input fmt required w/ stdin.\n'+usage)
  if not wegot_ofile and not ofmt: oms.SetFormat(OEFormat_SMI)
  
  i=0;
  for mol in ims.GetOEGraphMols():
    i+=1
    tpsa=CalcPSA(mol,SandP)
    if titleout: mol.SetTitle(mol.GetTitle()+(' TPSA=%.3f'%tpsa))
    if sdout: OESetSDData(mol,"TPSA",'%.2f'%tpsa)
    OEWriteMolecule(oms,mol)

  sys.stderr.write('%s result: %s mols \n'%(PROG,i))
