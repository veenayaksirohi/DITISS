#!/bin/bash

#-------------------------------------
# Aim : Declare array and take values from user
#-------------------------------------

# start your script here

declare -a arr

echo "Enter array elements : "
for ((i = 0 ; i < 5 ; i++))
do
	echo -n "arr[$i] : "
	read arr[$i]
done

echo -n "Array elements : "
for ((i = 0 ; i < ${#arr[*]} ; i++))
do
	echo -n " ${arr[$i]}"
done
echo ""















