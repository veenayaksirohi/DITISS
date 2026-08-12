#!/bin/bash

#-------------------------------------
# Aim : Package installation script
#-------------------------------------

# start your script here

# sources file for apt - /etc/apt/sources.conf

pkgs=(ncal git gcc vim net-tools)

echo "$0 : Updating sources file ..."
sudo apt-get update
if [ $? -ne 0 ]
then
	echo "$0 : Sources file is not updated ???"
	exit
fi
echo "$0 : Sources file is updated successfully !!!"

for pkg in ${pkgs[*]}
do
	echo "$0 : Installing $pkg package ..."
	sudo apt-get -y install $pkg
	if [ $? -ne 0 ]
	then
		echo "$0 : $pkg package is not installed ???"
	fi
	echo "$0 : $pkg is installed successfully !!!"
done

















