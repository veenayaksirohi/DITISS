#!/bin/bash

#-------------------------------------
# Aim : for loop
#-------------------------------------

#	C style 
#	for (( init ; condition ; modification ))
#	do
#		body
#	done

#	for each
#	for var in collection
#	do
#		body
#	done

#	collection - values seperated by space
#	for each loop do not needs modification


# start your script here

echo -n "Enter number : "
read num

echo "Table of $num : "
#	for (( i = 1 ; i < 11 ; i++ ))
#	for i in 1 2 3 4 5 6 7 8 9 10
for i in `seq 10`
do
	echo $(expr $i \* $num)
done



























