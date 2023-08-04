clear

realm=corp.arete.com
todaysDate=$(date +%F)

echo ""
echo ""
echo "Keytab Refresh tool"	
echo "Written by Anthony Haughton"
echo "Notes: Script must be run as root. Please make sure to delete the PC from AD when prompted"

echo "The current keytab and realm is:"
ls -lh /etc/krb5.keytab
realm list
sleep 2

echo "Making a backup of the sssd.conf file"
cp /etc/sssd/sssd.conf /etc/sssd/sssd.conf.bak
ls -lh /etc/sssd/
sleep 2

echo "Leaving realm and rejoining"
realm leave
sleep 1

# Prompt for username 
echo -n "Enter the username: "
read -r username

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
