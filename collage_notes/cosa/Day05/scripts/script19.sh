#!/bin/bash

#-------------------------------------
# Aim : Arrays
#-------------------------------------

#	Declaration
#		arr=(11 22 33 44 55)
#
#	${arr[*]}		-	all the elements of array
#	${#arr[*]}		-	length of array
#	${arr[$i]}		-	ith index element of array

#	${arr[*]:m}		-	all elements from mth index of array
#	${arr[*]:m:n}	-	n elements from mth index of array

# start your script here
arr=(11 22 33 44 55)

echo "Array : ${arr[*]}"
echo "Length : ${#arr[*]}"
echo "0th index element : ${arr[0]}"
echo "1st index element : ${arr[1]}"
echo "2nd index element : ${arr[2]}"
echo "3rd index element : ${arr[3]}"
echo "4th index element : ${arr[4]}"

echo "elements from 2nd index : ${arr[*]:2}"
echo "3 elements from 1st index : ${arr[*]:1:3}"

echo -n "Array (Using while loop) : "
i=0
while [ $i -lt ${#arr[*]} ]
do
	echo -n " ${arr[$i]}"
	i=`expr $i + 1`
done
echo ""

sum=0
for ele in ${arr[*]}
do
	sum=`expr $sum + $ele`
done

avg=`expr $sum / ${#arr[*]}`

echo "Avg = $avg"











