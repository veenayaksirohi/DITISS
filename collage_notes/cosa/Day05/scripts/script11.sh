#!/bin/bash

#-------------------------------------
# Aim : while and until loop
#-------------------------------------

#	init
#	while [ condition ]
#	do							# while condition is true execute body
#		body						# true - execute body
#		modification				# fasle - exit from loop
#	done

#	init
#	until [ condition ]
#	do							# until condition is true execute body
#		body						# false - execute body
#		modification				# true - exit from loop
#	done


# start your script here

echo -n "Enter number : "
read num

echo "Table of $num : "

i=1
#	while [ $i -lt 11 ]
until [ $i -eq 11 ]
do
	echo $(expr $i \* $num)
	i=$(expr $i + 1)
done


















