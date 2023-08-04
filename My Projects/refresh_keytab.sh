#!/bin/bash

clear

realm=corp.arete.com
todaysDate=$(date +%F)
machine=$(hostname)

echo ""
echo ""
echo "Keytab Refresh tool"	
echo "Written by Anthony Haughton"
echo "Notes: Script must be run as root. Please make sure to delete the PC from AD when prompted"

echo "The current keytab and realm is:"
ls -lh /etc/krb5.keytab

# Blank space 
echo ""
echo ""


echo "Making a backup of the sssd.conf file: "
cp /etc/sssd/sssd.conf /etc/sssd/sssd.conf.bak
ls -lh /etc/sssd/*.bak
sleep 3

# Blank space 
echo ""
echo ""


echo "Leaving realm"
realm leave
echo ""
echo ""

while :
do

    read -p "Did you remove $machine from the domain? You must do this before you continue.. (y/n): " domain_q

    if [ "$domain_q" = "y" ]; then
        sleep 1

        # Prompt for username to rejoin realm
        read -p "Enter the username: " username

        # Join the realm
        realm join "$realm" -U "$username"
        echo "welcome to $realm!"
        mv /etc/sssd/sssd.conf.bak /etc/sssd/sssd.conf
        systemctl restart sssd
        realm list
        sleep 1

        echo "Keytab should be updated to todays date: $todaysDate"
        ls -lh /etc/krb5.keytab
        sleep 3
        break

    else
        echo "You must remove the machine from AD."
        sleep 2
    fi
done