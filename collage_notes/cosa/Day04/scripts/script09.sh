#!/bin/bash

#-------------------------------------
# Aim :	Check string is palindrome or not 
#-------------------------------------

# start your script here

echo -n "Enter string : "
read str

if [ -z $str ]
then
	echo "str is empty"
	exit
fi

r_str=`echo $str | rev`

echo "str = $str, r_str = $r_str"

if [ $str = $r_str ]
then
	echo "str is palindrome"
else
	echo "str is not palindrome"
fi


























