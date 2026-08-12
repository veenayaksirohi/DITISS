#!/bin/bash

#-------------------------------------
# Aim : selection control structure	(case)
#-------------------------------------

#	case $choice in
#		1|3|One|Three)
#			...
#			;;
#		2|4|two)
#			...
#			;;
#		*)
#			...
#			;;
#	esac


# start your script here

echo -n "Enter two operands : "
read op1 op2

echo -e "1. Add\n2. Sub\n3. Mul\n4. Div"
echo -n "Which operation to be performed : "
read choice

case $choice in
	1)
		echo `expr $op1 + $op2`
		;;
	2)
		echo `expr $op1 - $op2`
		;;
	3)
		echo `expr $op1 \* $op2`
		;;
	4)
		echo `expr $op1 / $op2`
		;;
	*)
		echo "Invalid operation"
		;;
esac
















