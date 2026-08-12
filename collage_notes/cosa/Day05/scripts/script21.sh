#!/bin/bash

#-------------------------------------
# Aim : Positional parameters
#-------------------------------------

# Execute script as:
#	./script21.sh 10 A 3.142 sunbeam

#	$*	-	all positional parameters
#	$#	-	count of positional parameters

#	$i	-	ith positional parameter
#		$1 - 1st positional parameter	(10)
#		$2 - 2nd positional parameter	(A)
#		$3 - 3rd positional parameter	(3.142)
#		$4 - 4th positional parameter	(sunbeam)
#		...

#	$0 	-	name of script
#	$$	-	PID of bash shell which is interpreting the script

# start your script here

echo "Name of script : $0"
echo "PID of bash shell : $$"
echo "List of positional parameters : $*"
echo "Count of positional parameters : $#"

echo "1st parameter : $1"
echo "2nd parameter : $2"
echo "3rd parameter : $3"
echo "4th parameter : $4"


















