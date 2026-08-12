#!/bin/bash

#-------------------------------------
# Aim : Check number is prime or not
#-------------------------------------

# start your script here

echo -n "Enter number : "
read num

i=2
while [ $i -lt $num ]
do
	# check divisible by $i
	if [ $(expr $num % $i) -eq 0 ]
	then
		break
	fi
	i=$(expr $i + 1)
done

if [ $i -eq $num ]
then
	echo "$num is prime number"
else
	echo "$num is not prime number"
fi

















