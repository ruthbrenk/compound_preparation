#!/usr/bin/env python

import MySQLdb,sys
import MySQLdb.cursors


#-------------------------------------
def connect2server(password, user, db):
  try:
       conn = MySQLdb.connect (host = "biomed3100109.klientdrift.uib.no",
 			  user = user,
			  passwd = password,
			  db = db,
			  port = 3306)
       print "connected to server biomed3100109.klientdrift.uib.no "
       return conn
  except MySQLdb.OperationalError, message:
        errorMessage = "Error %d:\n%s" % (message[ 0 ], message[ 1 ] )
	print errorMessage
	print 'I was here'
	# quit the script if no connection could be established
	sys.exit(1)      
#-------------------------------------
def connect2server_dict(password, user, db):
  
  try:
       conn = MySQLdb.connect (host = "biomed3100109.klientdrift.uib.no",
 			  user = user,
			  passwd = password,
			  db = db,
			  port = 3306,
			  cursorclass=MySQLdb.cursors.DictCursor) 
       #print "connected to server"
       return conn
  except MySQLdb.OperationalError, message:
        errorMessage = "Error %d:\n%s" % (message[ 0 ], message[ 1 ] )
	print errorMessage
	# quit the script if no connection could be established
	sys.exit(1)      

#-------------------------------------
def encode_smiles(smiles):
	
    smiles = smiles.replace('\\','\\\\')

    return smiles
#-------------------------------------
def decode_smiles(smiles):
	
    smiles = smiles.replace('\\\\','\\')

    return smiles
