#!/bin/bash

#-------------------------------------
# Aim : Decision Control structure
#		Relational / Logical operator
#-------------------------------------

#	if [ condition ]
#	then
#		...
#	fi

#	if [ condition ]
#	then
#		...
#	else
#		...
#	fi

#	if [ condition ]
#	then
#		...
#	elif [ condition ]
#	then
#		...
#	else
#		...
#	fi


# Relational operators
#	-gt, -lt, -ge, -le, -eq, -ne

# Logical operators
#	-a, -o, !

# start your script here

# find maximum of two numbers

echo -n "Enter two numbers : "
read num1 num2

max=0

if [ $num1 -eq $num2 ]
then
	echo "num1 and num2 are equal"
	max=$num1
elif [ $num1 -gt $num2 ]
then
	echo "num1 is greater"
	max=$num1
else
	echo "num2 is greater"
	max=$num2
fi

echo "Maximum value = $max"
















