#!/bin/bash

#-------------------------------------
# Aim : String conditionals
#-------------------------------------

#	-z $str			: 	true if str is empty
#	-n $str			:	true if str is not empty
#	$str1 = $str2	:	true if str1 and str2 are equal
#	$str1 != $str2	:	true if str1 and str2 are not equal

# start your script here

str=
if [ -z $str ]
then
	echo "str is empty"
else
	echo "str is not empty"
fi

str1=sunbeam
str2=infotech

if [ $str1 = $str2 ]
then
	echo "str1 and str2 are equal"
else
	echo "str1 and str2 are not equal"
fi

str3=$str1$str2

echo "str3 = $str3"
echo "sub string from 7th index =  ${str3:7}"
echo "4 charcaters from 7th index =  ${str3:7:4}"




















