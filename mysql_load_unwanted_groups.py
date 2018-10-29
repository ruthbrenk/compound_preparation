#!/usr/bin/python

#load reactiviy flags in table, check that id exists

import string,os, sys
import my_mysql as mysql
import MySQLdb


if len(sys.argv) <> 5:
	print 'mysql_load_unwanted_groups.py  <username> <password> <data file> <project>'
	sys.exit(1)


username = sys.argv[1]
password = sys.argv[2]
data_file = open(sys.argv[3], 'r')
project = sys.argv[4]





#-------------------------------------
conn=mysql.connect2server(password, username,'purchasable')  			  
cursor = conn.cursor ()


#get table names

command = 'select unwanted_groups from projects where project = "' + project + '"'
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



#read first line of input data => is header
header = data_file.readline()

field_dict = {}
ordered_list = []

header = header.strip()
header = header.replace('identifier', id_field)

split_header = header.split('\t')

for i in range(0, len(split_header)):
	field_dict[split_header[i]]= i
	ordered_list.append(split_header[i])

#print field_dict

print "insert data"

for i in data_file.xreadlines():
     list = []
     start = 0
     for j in range(0,i.count('\t')):
       end = i.find('\t',start)
       value = string.strip(i[start:end])
       list.append(value)
       start = end + 1
     list.append(string.strip(i[start:]))
     
     #remove leading characters from label
     if list[0][0] == 'P':
	list[0] = list[0][1:]
     if list[0][0] == 'M':
	list[0] = list[0].replace('MFC','')
	
     #print list
     #make sure that label exits
     command = 'SELECT ' + id_field + ' FROM ' + table + ' WHERE ' + id_field + ' = "' + list[field_dict[id_field]] + '"'
     #print command    
     cursor.execute(command)
     label_exists = cursor.fetchall ()
     if len(label_exists) == 1 :
	#delete entry (other option would be to update it but I'm too lazy to change this script now)
	command = 'delete from ' + table + ' WHERE ' + id_field + ' = "' + list[field_dict[id_field]] + '"'  
	#print command
	cursor.execute(command)

     command = 'INSERT INTO ' + table + ' ('
     for field in ordered_list:
	if field <> id_field:
		command = command + ', '
	command = command + field
     command = command + ')'
     command = command + " VALUES "
     command = command + "(" + list[field_dict[id_field]] 
     for field in ordered_list:
	if field <> id_field:
		command = command + ", '" + list[field_dict[field]] + "'" 
     command = command + ")"
     #print command
     #try:
     cursor.execute(command)
     #except:
	#print list[field_dict[id_field]], ' does not exist'
   
print 'finished loading unwanted groups'    
cursor.close ()
conn.commit()
conn.close ()
