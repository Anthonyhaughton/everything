#!/bin/bash

clear

# Make vars for script 
realm=corp.realm.test
todaysDate=$(date +%F)
machine=$(hostname)

echo ""
echo ""
echo "Keytab Refresh Tool"	
echo "Written by Anthony Haughton"
echo "Notes: Script must be run as root. Please make sure to delete the PC from AD when prompted"
echo ""

echo "The current keytab is:"
ls -lh /etc/krb5.keytab
sleep 2

# Blank space 
echo ""
echo ""

# Back up conf file and show backup file. Using a unique name to be safe and make sure no back up already exists
echo "Making a backup of the sssd.conf file see below: "
cp /etc/sssd/sssd.conf /etc/sssd/sssd.conf.bak_keytab_script
ls -lh /etc/sssd/*.bak*
sleep 3

# Blank space 
echo ""
echo ""

# Leave the realm
echo "Leaving realm.."
realm leave
echo ""
echo ""

while :
do
    # Induce infinite loop to make sure user has removed machine from AD
    read -p "Did you remove $machine from the domain? You must do this before you continue.. (y/n): " domain_q

    # Check to make sure user said yes and if not reprompt
    if [ "$domain_q" = "y" ]; then
        sleep 1

        # Prompt for username to rejoin realm
        read -p "Enter the username: " username

        # Join the realm move sssd.conf back and restart the service
        realm join "$realm" -U "$username"
        echo ""
        echo "Welcome to $realm!"
        mv -f /etc/sssd/sssd.conf.bak_keytab_script /etc/sssd/sssd.conf
        systemctl restart sssd
        realm list
        echo ""
        sleep 1

        # Show new keytab
        echo "Keytab should be updated to todays date: $todaysDate"
        ls -lh /etc/krb5.keytab
        echo ""
        sleep 3
        # break out of infinite loop
        break

    else
        echo "You must remove the machine from AD before proceeding."
        sleep 2
    fi
done