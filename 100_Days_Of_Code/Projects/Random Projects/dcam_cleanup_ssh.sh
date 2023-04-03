#!/bin/bash

menu ="100"

while [ menu != "10" ]
do

	echo ""
	echo ""
	echo "DCAM Project Folder Helper"
	echo "Written by Anthony Haughton"
	echo "Notes: Script must be run as root and on any DCAM machine."
	echo "-------------------------------------------"
	echo "1.  Make Folder"
	echo "10. Quit"
	echo "-------------------------------------------"
	read -p "Enter your selection: " menu

	if [ $menu = "1" ]; then

		# Choose machine to ssh into
		echo -n "What machine do you want to make the folder on? "
		read -r ssh_machine

		# Get folder name
		echo -n "What folder do you want to create? "
		read -r folder

		# Ask if they know the group for the folder
		echo -n "Do you know the AD group for this folder? y/n: "
		read -r ask_group

		# Get machine name
		#machine=$(hostname | tr '[:upper:]' '[:lower:]')

		# ssh in and create folder and set permissions on slow drive
		ssh $ssh_machine -t -q "mkdir /mnt/$ssh_machine/slow01/$folder && chown :root /mnt/$ssh_machine/slow01/$folder && chmod 2770 /mnt/$ssh_machine/slow01/$folder"

		# Ask if they want to create the same folders on the fast drive
		echo -n "Do you want to make the same folder on the fast drive? y/n: "
		read -r fast

		if [ $fast = y ]; then
			ssh $ssh_machine -t -q "mkdir /mnt/$ssh_machine/fast01/$folder && chown :root /mnt/$ssh_machine/fast01/$folder && chmod 2770 /mnt/$ssh_machine/fast01/$folder"
		fi

		if [ $ask_group = y ]; then
				echo -n "What's the group? "
				read -r group
			ssh $ssh_machine -t -q "chgrp $group /mnt/$ssh_machine/slow01/$folder && chgrp $group /mnt/$ssh_machine/fast01/$folder"
		fi
		
		echo ""
		echo "The $folder folder has been created on $ssh_machine!"
		sleep 5
	
		echo "Do you want to make another folder? y/n: "
		read -r user_choice

		if [ $user_choice = "n" ]; then
			exit
		fi

	elif [ $menu = "10" ]; then
		exit
	fi

done