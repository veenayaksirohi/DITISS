#!/bin/bash

#-------------------------------------
# Aim : Count number of files and directories in current directory 
#-------------------------------------

# start your script here

f_cnt=0
d_cnt=0
for entry in `ls`
do
	if [ -f $entry ]
	then
		f_cnt=`expr $f_cnt + 1`
	elif [ -d $entry ] 
		d_cnt=`expr $d_cnt + 1`
	fi
done

echo "Current directory : $PWD"
echo "file count : $f_cnt"
echo "dir count : $d_cnt"
















