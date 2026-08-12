#!/bin/bash

#-------------------------------------
# Aim : check conditions with patterns(regular expressions)
#-------------------------------------

#	if [[ $str =~ pattern ]]
#		- true if pattern matches with str

# start your script here

# count hidden files in a current directory

cnt=0
for entry in `ls -A`
do
	if [[ $entry =~ ^\. ]]
	then
		cnt=`expr $cnt + 1`
	fi
done

echo "hidden files count = $cnt"

echo "Using grep command : "
cnt=`ls -A | grep -c "^\."`
echo "hidden files count = $cnt"
















