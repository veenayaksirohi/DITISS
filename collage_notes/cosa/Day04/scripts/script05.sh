#!/bin/bash

#-------------------------------------
# Aim : Find area of reactangle
#-------------------------------------

# start your script here

echo -n "Enter length and breadth of reangle : "
read le br

# command substitution
#	result of a command is substituted at the place of command
#	method 1 :	`command`
#	method 2 :	$(command)

area=$(expr $le \* $br)

echo "Area of reactangle : $area"

















