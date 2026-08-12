#!/bin/bash

#-------------------------------------
# Aim :	Find area of circle 
#-------------------------------------

# start your script here

echo -n "Enter radius of a circle : "
read radius

area=$(echo "3.142 * $radius * $radius" | bc)

echo "Area of circle : $area"
















