#!/usr/bin/python

#load clogP in table, check that id exists

import string,os, sys
import my_mysql as mysql
import MySQLdb

if len(sys.argv) <> 5:
	print 'mysql_load_clogp.py  <username> <password> <data_file> <project>'
	sys.exit(1)

username = sys.argv[1]
password = sys.argv[2]
data_file = open(sys.argv[3], 'r')
project = sys.argv[4]


#-------------------------------------

  
conn=mysql.connect2server(password, username, 'purchasable')  			  
			  
cursor = conn.cursor ()

#get table names

command = 'select unique_compounds from projects where project = "' + project + '"'
print command
cursor.execute(command)
results=cursor.fetchall()
if len(results) == 0:
	print 'project does not exist'
	sys.exit(1)

table = results[0][0]

#get id,
command = "show fields from " + table
cursor.execute(command)
results=cursor.fetchall()
for result in results:
	if result[3] == 'PRI':
		id_field = result[0]



print "insert data"



for i in data_file.xreadlines():
    #print i
  if len(i) > 2: #sybyl adds empty line or just komma at end of file
    i = i.replace(', ',',')
    i = i.replace(' ',',')
    if i.count(',') ==2:
    	id, clogp, junk = string.split(i.strip(),',') 
    	id = id.replace('P','')
    else:
	id = i[:-2]
	clogp = '99999'
	#print id,clogp
    
    #id, clogp, error = string.split(i.strip(),'\t')
    if clogp == '-':
      clogp = '99999'

    #make sure that label exits
    command = 'SELECT ' + id_field + ' FROM ' + table + ' WHERE ' + id_field + ' = ' + id
    #print command
    cursor.execute(command)
    results = cursor.fetchall ()
    if len(results) == 1 and clogp <> '':
        #print id
    	command = 'UPDATE ' + table + ' SET clogP = ' + clogp
    	command = command + " WHERE " + id_field + "=" + id
    	#print command
    	cursor.execute(command)
    else:
     print str(id) +' does not exist'
   
    
cursor.close ()
conn.commit()
conn.close ()
