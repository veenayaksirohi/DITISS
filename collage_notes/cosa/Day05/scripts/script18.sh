#!/bin/bash

#-------------------------------------
# Aim : select statement/command
#-------------------------------------

#	select var in collection
#	do
#		...
#	done

#	at start it will show values from collection along with choice
#	enter choice
#	corresponding value will be there in var for current iteration
#	terminate on EOF


# start your script here

select opr in Add Sub Mul Div
do
	#	echo $opr
	if [ -n $opr ]
	then
		echo -n "Enter two operands : "
		read op1 op2
	fi

	case $opr in
		Add)
			echo `expr $op1 + $op2`
			;;
		Sub)
			echo `expr $op1 - $op2`
			;;
		Mul)
			echo `expr $op1 \* $op2`
			;;
		Div)
			echo `expr $op1 / $op2`
			;;
		*)
			echo "Invalid operation"
			;;
	esac
done



















