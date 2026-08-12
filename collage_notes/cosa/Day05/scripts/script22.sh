#!/bin/bash

#-------------------------------------
# Aim : Functions 
#-------------------------------------

#	Function definition
#	method 1 :
#		function funName
#		{
#			...
#		}

#	method 2 :
#		funName()
#		{
#			...
#		}

#	function parameters are accessed as $1, $2, $3, ...

# start your script here

function print_msg
{
	echo "This is my first function in bash"
}

function print_value
{
	echo "inside print_value() function"
	echo "value = $1"
}

factorial()
{
	# num --> $1
	fact=1
	for (( i = 1 ; i <= $1 ; i++ ))
	do
		fact=`expr $fact \* $i`
	done
	echo $fact
}


# main script
echo "main script"

#	print_msg

#	print_value 10
#	print_value A
#	print_value 3.142
#	print_value sunbeam

fact=`factorial 5`
echo "5! = $fact"















