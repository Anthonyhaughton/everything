#!/bin/bash

# 04/30/2023

menu="100"

while [ "$menu" != "10" ]
do

	echo ""
	echo ""
	echo "DCAM Project Folder Helper"
	echo "Written by Anthony Haughton"
	echo "Notes: Script must be run as root"
	echo "-------------------------------------------"
	echo "1.  Make Folder (Remotely)"
	echo "2.  Make Folder (Locally)"
	echo "10. Quit"
	echo "-------------------------------------------"
	read -p "Enter your selection: " menu

	if [ $menu = "1" ]; then

		# Get folder name

		echo -n "What folder do you want to create? "
		read -r folder

		# Ask if they know the group for the folder

		echo -n "Do you know the AD group for this folder? y/n: "
		read -r ask_group

		# Get machine name
		machine=$(hostname | tr '[:upper:]' '[:lower:]')

		# Create folder and set permissions on slow drive
		mkdir /mnt/$machine/slow01/$folder
		chown :root /mnt/$machine/slow01/$folder
		chmod 2770 /mnt/$machine/slow01/$folder

		# Ask if they want to create the same folders on the fast drive
		echo "Do you want to make the same folder on the fast drive? y/n: "
		read -r fast

		# Make fast drive folders
		if [ $fast = y ]; then
			mkdir /mnt/$machine/fast01/$folder
			chown :root /mnt/$machine/fast01/$folder
			chmod 2770 /mnt/$machine/fast01/$folder
		fi

		# Change group for folders
		if [ $ask_group = y ]; then
				echo -n "What's the group? "
				read -r group
			chgrp $group /mnt/$machine/slow01/$folder
			chgrp $group /mnt/$machine/fast01/$folder
		fi
		
		echo ""
		echo "The $folder folder has been created on $machine"
		sleep 5
	
	elif [ $menu = "10" ]; then
		exit
	fi

done