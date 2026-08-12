#!/bin/bash

#-------------------------------------
# Aim : File conditionals
#-------------------------------------

#	-e $path	:	true if path exists
#	-f $file	:	true if file is regular file
#	-d $file	:	true if file is directory file
#	...
#	-r $file	:	true if file has read access
#	-w $file	:	true if file has write access
#	-x $file	:	true if file has execute access


# start your script here

echo -n "Enter path : "
read path

if [ -e $path ]
then
	echo "path exist"
	if [ -f $path ]
	then
		echo "regluar file"
	elif [ -d $path ]
	then
		echo "Directory file"
	else
		echo "something else"
	fi
		
else
	echo "path doesn't exist"
fi

















