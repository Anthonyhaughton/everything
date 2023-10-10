#!/bin/bash
systemLogPath="/var/log"
auditLogPath="/var/log/audit/AUDITS"
dateToday=$(date +%F)
logReview=""
selectionLogDate=""

clear
menu="10000"
auditMenu="10000"

while [[ $menu != "10" ]]
do
	echo
	echo
	echo
	echo "Arete's Linux Audit Tool & AV Definition Checker v2.0"
	echo "Written by Devon Wiggins"
	echo "Notes:  Script must be run as root"
	echo "-------------------------------------------------------------------------------"
	echo "1.  Save & Clear Audit Logs"
	echo "2.  Review Audit Logs"
	echo "3.  Update McAfee AV Definitions for McAfee Endpoint Security for Linux Threat Protection"
	echo "4.  View McAfee AV Definitions"
	echo "10. Exit"
	echo "-------------------------------------------------------------------------------"
	read -p "Enter your selection: " menu
	echo
	echo
	echo

	if [[ $menu = "1" ]]; then
		#Create the Audit Log Path with today's date
		echo "Creating Directory $auditLogPath/$dateToday"
		sudo mkdir -p $auditLogPath/$dateToday

		#Copy audit.log file
		echo "Copying $systemLogPath/audit/audit.log to $auditLogPath/$dateToday"
		sudo rsync --progress $systemLogPath/audit/audit.log $auditLogPath/$dateToday
				
		#Copy messages file
		echo "Copying $systemLogPath/messages to $auditLogPath/$dateToday"
		sudo rsync --progress $systemLogPath/messages $auditLogPath/$dateToday
		
		#Copy secure file
		echo "Copying $systemLogPath/secure to $auditLogPath/$dateToday"
		sudo rsync --progress $systemLogPath/secure $auditLogPath/$dateToday

		#Blank Line of Text
		echo ""

		#Clear audit.log file
		echo "Clearing $systemLogPath/audit/audit.log"
		sudo sh -c "cat /dev/null > $systemLogPath/audit/audit.log"

		#Clear messages file
		echo "Clearing $systemLogPath/messages"
		sudo sh -c "cat /dev/null > $systemLogPath/messages"

		#Clear secure file
		echo "Clearing $systemLogPath/secure"
		sudo sh -c "cat /dev/null > $systemLogPath/secure"

	elif [[ $menu = "2" ]]; then		
		auditMenu="100000"
		while [[ $auditMenu != "10" ]]
		do				
			echo "-------------------------------------------------------------------------------"
			echo "Audit Log Review Menu:"
			echo "-------------------------------------------------------------------------------"
			echo "1.  Select Saved Logs to View"
			echo "2.  Summary of System Events"		
			echo "3.  Login Report - Summary"
			echo "4.  Login Report - Successful Attempts"
			echo "5.  Login Report - Failed Attempts"
			echo "6.  Report of Executable File Events"
			echo "7.  Report of User's Actions"
			echo "8.  Report of All Linux Account, Group, and Role Changes"
			echo "9.  Report of all mounted and unmounted devices (Removable media, USB, etc)"
			echo "10. Return to Previous Menu"
			echo "11. Exit"
			echo "-------------------------------------------------------------------------------"
			read -p "Enter your selection: " auditMenu
			echo
			echo
			echo
					
			if [[ $auditMenu = "1" ]]; then
				#Select Saved Logs to Audit
				echo "Audit Files in $auditLogPath"
				echo "-------------------------------------------------------------------------------"
				i=0
				for file in $auditLogPath/*
				do
				        echo "$((i+1)). ${file##*/}"
				        files[$i]=$file
				        ((i++))
				done

			echo "$((i+1)). Exit"
			echo "-------------------------------------------------------------------------------"
                        read -p "Select Item: " selection
                        if ! [[ "$selection" =~ ^[0-9]+$ ]] ;
                          then exec >&2; echo "error: Not a number"; exit 1
                        else
                                echo "User Selection: " $selection
                                temp="$((selection-1))"
                                logReview=("${files[$temp]}")
			fi
		elif [[ $auditMenu = "2" ]]; then
			#Summary of System Events
			sudo aureport --input $logReview/audit.log | less				
			
		elif [[ $auditMenu = "3" ]]; then
			#Login Report - Summary
			sudo aureport --input $logReview/audit.log --login --summary -i | less
				
			elif [[ $auditMenu = "4" ]]; then
				#Login Report - Successful Attempts
				sudo aureport --input $logReview/audit.log -u --success -i | less
				
			elif [[ $auditMenu = "5" ]]; then
				#Login Report - Failed Attempts
				sudo aureport --input $logReview/audit.log -u --failed -i | less
				
			elif [[ $auditMenu = "6" ]]; then
				#Report of Executable File Events
				sudo aureport --input $logReview/audit.log -x -i | less
				
			elif [[ $auditMenu = "7" ]]; then
				#Report of a Particular User's Accounts
				read -p "Enter username: " selectionUser
				selectionUserID=$(id -u $selectionUser)
				echo $selectionUser $selectionUserID
				sudo ausearch --input $logReview/audit.log -ua $selectionUserID -i | less
				
			elif [[ $auditMenu = "8" ]]; then
				#Report of All Linux Account, Group, and Role Changes
				sudo ausearch --input $logReview/audit.log -m ADD_USER -m DEL_USER -m ADD_GROUP -m USER_CHAUTHTOK -m DEL_GROUP -m CHGRP_ID -m ROLE_ASSIGN -m ROLE_REMOVE -i | less

			elif [[ $auditMenu = "9" ]]; then
				#Report all mounted & unmounted commands
				sudo ausearch --input $logReview/audit.log -k mount_umount | less
				
			elif [[ $auditMenu = "10" ]]; then
				#Return to Previous Menu
				break
				
			elif [[ $auditMenu = "11" ]]; then
				#Exit Script
				exit
			fi
		done
	elif [[ $menu = "3" ]]; then		
			
#Create variable for McAfee DAT version #
		mcafeeDatVersion=$(ls mediumdat*.zip | grep -o '[0-9]*')
		echo McAfee Dat Version: $mcafeeDatVersion

#Create variable for current value of "MajorDATVersion" to be used in sed to find value
		origVar=$(grep -io '<MajorDATVersion>*[0-9]*' /var/McAfee/ens/tp/prefs.xml)
		echo McAfee Current DAT Version: $origVar
		
#Create variable for sed to replace $origVar value 
		newVar='<MajorDATVersion>'$mcafeeDatVersion''
		echo Replacement McAfeeDatVersion: $mcafeeDatVersion
		
		mkdir mediumtmp
		unzip mediumdat-*.zip -d $PWD/mediumtmp
		cd mediumtmp
		
		mkdir /var/McAfee/ens/tp/dat/$mcafeeDatVersion
		chmod 600 /var/McAfee/ens/tp/dat/$mcafeeDatVersion

		cp -f $PWD/*.dat /var/McAfee/ens/tp/dat/$mcafeeDatVersion
		chmod -R 600 /var/McAfee/ens/tp/dat/$mcafeeDatVersion

		ls -lha /var/McAfee/ens/tp/dat/$mcafeeDatVersion/med*

		#Edit /opt/isec/ens/threatprevention/var/prefs.xml to change the MajorDatVersion
		#Replace the <MajorDatVersion)OLDVERSION#</MajorDatVersion> with $mcafeeDatVersion
		#Fix breakout characters that need to be in the line. Figure out the method to do it.
		#sed -i '/s<MajorDatVersion>*</MajorDatVersion>/<MajorDatVersion>$mcafeeDatVersion</MajorDatVersion>/g' /var/McAfee/ens/tp/prefs.xml
		sed -i 's|'$origVar'|'$newVar'|g' "/var/McAfee/ens/tp/prefs.xml"

		#Restart the service
		/opt/McAfee/ens/tp/init/mfetpd-control.sh restart

		sleep 10

		#Show the latest DAT Versions
		echo /opt/McAfee/ens/tp/bin/mfetpcli --version
		/opt/McAfee/ens/tp/bin/mfetpcli --version

		cd ..
		rm -rf mediumtmp
		
	elif [[ $menu = "4" ]]; then		
		/opt/McAfee/ens/tp/bin/mfetpcli --version
	fi
done