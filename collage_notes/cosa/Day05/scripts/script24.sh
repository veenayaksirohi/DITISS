#!/bin/bash

#-------------------------------------
# Aim : seperate image and video files
#-------------------------------------

# start your script here

for entry in `ls`
do
	if [[ $entry =~ \.png$ ]]
	then
		mv $entry d1
	elif [[ $entry =~ \.mp4$ ]]
	then
		mv $entry d2
	fi
done

echo "Images and videos are seperated !!!"

















