#!/bin/bash

# Prompt for hostname
echo -n "Enter the hostname of the machine: "
read hostname

# Set hostname and restart service
hostnamectl set-hostname $hostname
systemctl restart systemd-hostnamed

# Prompt for IP configuration type
echo -n "Is the IP address going to be static or DHCP? (static/dhcp) "
read ip_config

if [ "$ip_config" = "static" ]; then
    # Prompt for IP information
    echo -n "Enter the IP address: "
    read ip
    echo -n "Enter the subnet mask: "
    read subnet
    echo -n "Enter the gateway: "
    read gateway
    echo -n "Enter the primary DNS server: "
    read dns1
    echo -n "Enter the secondary DNS server: "
    read dns2
    echo -n "Enter the network interface to configure (e.g. ens3): "
    read interface

    # Set IP information
    nmcli connection modify $interface ipv4.addresses "$ip/$subnet"
    nmcli connection modify $interface ipv4.gateway "$gateway"
    nmcli connection modify $interface ipv4.dns "$dns1 $dns2"

elif [ "$ip_config" = "dhcp" ]; then
    echo -n "Enter the network interface to configure (e.g. ens3): "
    read interface
    nmcli connection modify $interface ipv4.method auto
else
    echo "Invalid input"

# Display the new IP settings
ip a show dev $interface

# Wait 10 seconds
sleep 10

# Check if machine should be added to domain
echo -n "Do you want to add this machine to the domain? (y/n) "
read add_to_domain

if [ "$add_to_domain" = "y" ]; then
    # Join the realm
    realm join $realm -U $username

    # Modify sssd.conf
    sed -i 's/services.*/services = nss, pam, ssh, autofs/' /etc/sssd/sssd.conf
    sed -i 's/use_fully_qualified_names.*/use_fully_qualified_names = False/' /etc/sssd/sssd.conf
    sed -i 's/fallback_homedir.*/fallback_homedir = \/home\/%u/' /etc/sssd/sssd.conf
    echo "ad_gpo_ignore_unreadable=True" >> /etc/sssd/sssd.conf

    # Restart sssd service
    systemctl restart sssd

# Prompt Sever or Workstation to update sudoers
echo -n "Is this a server or workstation? (server/workstation) "
read machine_type

if [ "$machine_type" = "server" ]; then
    # Create file for server admins
    echo "%Server Admins - Linux Servers ALL=(ALL) ALL" > /etc/sudoers.d/ad_server_admins

elif [ "$machine_type" = "workstation" ]; then
    # Create file for client admins
    echo "%Linux Client Administrators ALL=(ALL) ALL" > /etc/sudoers.d/ad_client_admins

else
    echo "Invalid input"

# Prompt to subscribe to Red Hat Repo Manager
echo -n "Do you want to subscribe this machine to the Red Hat Repo Manager? (y/n) "
read subscribe

if [ "$subscribe" = "y" ]; then
    # Prompt for email
    echo -n "What is your email? "
    read email

    # Register and attach subscription
    subscription-manager register --username $email --auto-attach

    # Print current subscription status
    subscription-manager status
	
	# Prepare the machine to update
    rm -rf /var/cache/dnf
    dnf clean all

    # Make new repository cache
    dnf makecache

    # Update the machine
    dnf update

else
    echo "The repository will have to be set up manually."
	sleep 2
	
	# Figure out if repos will be pulled from server or if they will be installed locally
	echo -n "Are you going to connect the machine to a repo server or do you have the repos local? (server/local) "
	read where_repo
	
	if [ "$where_repo" = "server" ]; then
	
		# Ask user for the IP of the repo server
		echo -n "What server will you be pulling the repos from? Enter the IP."
		read repo_server
		
		# Configure the redhat.repo file for BaseOS
		echo "[rhel-8-for-x86_64-baseos-rpms]" > /etc/yum.repos.d/redhat.repo
		echo "name = Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs)" >> /etc/yum.repos.d/redhat.repo
		echo "baseurl = http://$repo_server" >> /etc/yum.repos.d/redhat.repo
		echo "enabled=1" >> /etc/yum.repos.d/redhat.repo
		
		# Put a space in between the two repos
		printf "\n" >> /etc/yum.repos.d/redhat.repo
		
		# Configure the redhat.repo file for AppStream
		echo "[rhel-8-for-x86_64-appstream-rpms]" >> /etc/yum.repos.d/redhat.repo
		echo "name = Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs)" >> /etc/yum.repos.d/redhat.repo
		echo "baseurl = http://$repo_server" >> /etc/yum.repos.d/redhat.repo>> /etc/yum.repos.d/redhat.repo
		echo "enabled=1" >> /etc/yum.repos.d/redhat.repo
	
	elif [ "$where_repo" = "local" ]; then
		
		# Create a directory to mount the repos 
		echo "Creating directory to mount local repo at /mnt/usb/rhel_repos"
		mkdir -p /mnt/usb/rhel_repos
		
fi