#!/bin/bash

#-------------------------------------
# Aim : Count number of entries in current directory 
#-------------------------------------

# start your script here

cnt=0
for entry in `ls`
do
	cnt=`expr $cnt + 1`
done

#	echo -n "Current directory : " ; pwd
echo "Current directory : $PWD"
echo "Entries in current directory : $cnt"
















