#!/bin/bash

clear
menu="100"

while [ "$menu" != "10" ]
do

    echo
    echo
    echo "Red Hat 8 Build Helper"
    echo "Written by Anthony Haughton"
    echo "Notes:  Script must be run as root"
    echo "---------------------------------------------------------------------"
    echo "1.  Set Hostname "
    echo "2.  Set IP Information "
    echo "3.  Join Realm "
    echo "4.  Update Sudoers "
    echo "5.  Set up Repositories/ Nvidia Drivers "
    echo "6.  Configure Environment Modules "
    echo "10. Exit "
    echo "---------------------------------------------------------------------"
    read -p "Enter your selection: " menu

    if [ "$menu" = "1" ]; then
        # Prompt for hostname
        echo -n "Enter the hostname of the machine: "
        read -r hostname

        # Set hostname and restart service
        hostnamectl set-hostname "$hostname"
        systemctl restart systemd-hostnamed
    
    elif [ "$menu" = "2" ]; then

        # Prompt for IP configuration type
        echo -n "Is the IP address going to be static or DHCP? (static/dhcp) "
        read -r ip_config

        if [ "$ip_config" = "static" ]; then
            # Prompt for IP information
            echo -n "Enter the IP address: "
            read -r ip
            echo -n "Enter the subnet mask: "
            read -r subnet
            echo -n "Enter the gateway: "
            read -r gateway
            echo -n "Enter the primary DNS server: "
            read -r dns1
            echo -n "Enter the secondary DNS server: "
            read -r dns2
            echo -n "Enter the network interface to configure (e.g. ens3): "
            read -r interface

            # Set IP information
            nmcli connection modify "$interface" ipv4.addresses "$ip/$subnet"
            nmcli connection modify "$interface" ipv4.gateway "$gateway"
            nmcli connection modify "$interface" ipv4.dns "$dns1 $dns2"

        elif [ "$ip_config" = "dhcp" ]; then
            echo -n "Enter the network interface to configure (e.g. ens3): "
            read -r interface
            nmcli connection modify "$interface" ipv4.method auto
        else
            echo "Invalid input"

        # Display the new IP settings
        ip a show dev "$interface"

        # Wait 10 seconds
        sleep 10

        fi
    
    elif [ "$menu" = "3" ]; then

        # Check if machine should be added to domain
        echo -n "Do you want to add this machine to the domain? (y/n) "
        read -r add_to_domain

        if [ "$add_to_domain" = "y" ]; then

            # Prompt for username and realm
            echo -n "Enter the username: "
            read -r username
            echo -n "Enter the realm: "
            read -r realm

            # Join the realm
            realm join "$realm" -U "$username"
            echo "welcome to $realm!"
            realm list
            sleep 3

            # Modify sssd.conf
            sed -i 's/services.*/services = nss, pam, ssh, autofs/' /etc/sssd/sssd.conf
            sed -i 's/use_fully_qualified_names.*/use_fully_qualified_names = False/' /etc/sssd/sssd.conf
            sed -i 's/fallback_homedir.*/fallback_homedir = \/home\/%u/' /etc/sssd/sssd.conf
            echo "ad_gpo_ignore_unreadable=True" >> /etc/sssd/sssd.conf

            # Restart sssd service
            systemctl restart sssd

        fi

    elif [ "$menu" = "4" ]; then

        # Prompt Sever or Workstation to update sudoers
        echo -n "Is this a server or workstation? (server/workstation) "
        read -r machine_type

        if [ "$machine_type" = "server" ]; then
            # Create file for server admins
            echo "%Server Admins - Linux Servers ALL=(ALL) ALL" > /etc/sudoers.d/ad_server_admins
            echo "Added group to sudoers"
            sleep 3

        elif [ "$machine_type" = "workstation" ]; then
            # Create file for client admins
            echo "%Linux Client Administrators ALL=(ALL) ALL" > /etc/sudoers.d/ad_client_admins

        else
            echo "Invalid input"

        fi

    elif [ "$menu" = "5" ]; then

        # Prompt to subscribe to Red Hat Repo Manager
        echo -n "Do you want to subscribe this machine to the Red Hat Repo Manager? (y/n) "
        read -r subscribe

        if [ "$subscribe" = "y" ]; then
            # Prompt for email
            echo -n "What is your email? "
            read -r email

            # Clear out repo directory
            mv /etc/yum.repos.d/* /etc/yum.repos.d/archive

            # Register and attach subscription
            subscription-manager register --username "$email" --auto-attach

            # Print current subscription status
            subscription-manager list
            sleep 2

            # Update user
            echo "Preparing to update the machine."
            
            # Prepare the machine to update
            rm -rf /var/cache/dnf
            dnf clean all

            # Make new repository cache
            dnf makecache

            # Update the machine
            dnf update

            # Update user
            echo "The machine has been updated"
            sleep 2

            # Ask to download Nvidia Drivers
            echo -n "Do you want to install the latest Nvidia drivers? (y/n)"
            read -r drivers



            if [ "$drivers" = "y" ]; then

                # Download dependency on EPEL for DKMS and enable optional repos
                yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
                subscription-manager repos --enable="rhel-*-optional-rpms" --enable="rhel-*-extras-rpms"  --enable="rhel-ha-for-rhel-*-server-rpms"

                # Install the CUDA Repo GPG Key
                distribution=$(. /etc/os-release;echo "$ID"'rpm -E "%{?rhel}%{?fedora}"')

                # Setup the CUSA repo
                ARCH=$( /bin/arch )
                yum-config-manager --add-repo http://developer.download.nvidia.com/compute/cuda/repos/$distribution/${ARCH}/cuda-$distribution.repo

                # Make sure the correct kernels are present for the install
                dnf install -y kernel-devel-"$(uname -r)" kernel-headers-"$(uname -r)"

                # Update repo cache and install nvidia driver
                dnf clean expire-cache
                yum install -y nvidia-driver-latest-DKMS
                
                # Reboot
                echo "The machine needs to be rebooted so DKMS can be updated. Please reboot after the script has finished."
                nvidia-smi
            
            fi

        else 
            echo "The repository will have to be set up manually."
            sleep 2

        fi
            
            # Figure out if repos will be pulled from server or if they will be installed locally
            echo -n "Are you going to connect the machine to a repo server or do you have the repos local? (server/local) "
            read -r where_repo
            
            if [ "$where_repo" = "server" ]; then
            
                # Ask user for the IP of the repo server
                echo -n "What server will you be pulling the repos from? Enter the IP. "
                read -r repo_server

                # Clear out repo directory
                mv /etc/yum.repos.d/* /etc/yum.repos.d/archive

                # Let's try this 
                dnf config-manager --add-repo http://$repo_server/rhel-8-for-x86_64-baseos-rpms
                dnf config-manager --add-repo http://$repo_server/rhel-8-for-x86_64-appstream-rpms
                
                # Configure the redhat.repo file for BaseOS
                # {
                #     echo "[rhel-8-for-x86_64-baseos-rpms]" 
                #     echo "name = Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs)" 
                #     echo "baseurl = http://$repo_server/rhel-8-for-x86_64-baseos-rpms" 
                #     echo "enabled=1" 
                #     # Put a space in between the two repos
                #     printf "\n" >> /etc/yum.repos.d/redhat.repo
                # } > /etc/yum.repos.d/redhat.repo

                
                # Configure the redhat.repo file for AppStream
                {
                    echo "[rhel-8-for-x86_64-appstream-rpms]" 
                    echo "name = Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs)" 
                    echo "baseurl = http://$repo_server/rhel-8-for-x86_64-appstream-rpms" 
                    echo "enabled=1" 
                } >> /etc/yum.repos.d/redhat.repo

                # Update user
                echo "The repository information has been configured. Preparing to update the machine."

                # Prepare the machine to update
                rm -rf /var/cache/dnf
                dnf clean all

                # Make new repository cache
                dnf makecache

                # Update the machine
                dnf update
            
            
            elif [ "$where_repo" = "local" ]; then
                
                # Create a directory to mount the repos 
                echo "Creating directory to mount local repo. Mount your drive at /mnt/usb/rhel_repos"
                mkdir -p /mnt/usb/rhel_repos

                # Clear out repo directory
                mv /etc/yum.repos.d/* /etc/yum.repos.d/archive

                # Configure local redhat.repo file for BaseOS
                {
                    echo "[rhel-8-for-x86_64-baseos-rpms]" 
                    echo "name = Red Hat Enterprise Linux 8 for x86_64 - BaseOS (RPMs)" 
                    echo "baseurl = file:///mnt/usb/rhel_repos/rhel-8-for-x86_64-baseos-rpms" 
                    echo "enabled=1" 
                    echo "gpgcheck=0"
                    # Put a space in between the two repos
                    printf "\n"
                } > /etc/yum.repos.d/redhat.repo
                
                
                # Configure local redhat.repo file for AppStream
                {
                    echo "[rhel-8-for-x86_64-appstream-rpms]" 
                    echo "name = Red Hat Enterprise Linux 8 for x86_64 - AppStream (RPMs)" 
                    echo "baseurl = file:///mnt/usb/rhel_repos/rhel-8-for-x86_64-appstream-rpms" 
                    echo "enabled=1" 
                    echo "gpgcheck=0" 
                } >> /etc/yum.repos.d/redhat.repo
            fi

    elif [ "$menu" = "6" ]; then

        # Ask to install env modules 
        echo -n "Do you want to configure modules? (y/n) "
        read -r env_modules

        if [ "$env_modules" = "y" ]; then
            
            # Install the package
            dnf install environment-modules -y

            # provide an example module file to be copied and used for any program
            echo "Env Modules were installed, you can configure the module files at /usr/share/Modules/modulefiles"
            echo "There is an example on how to make a module files in the path, you can replace with your own application"
            sleep 5

            # Make example mod file
            touch /usr/share/Modules/modulefiles/example
            {
                echo "#%Module -*- tcl -*-"
                echo "##"
                echo "## modulefile"
                echo "##"
                echo "proc ModulesHelp { } {"
                printf "\n"
                echo "  puts stderr '\tLoads (Application)/(version)"
                echo "}"
                printf "\n"
                echo "module-whatis 'Loads (Application)(Version)'"
                echo "conflict (Application)"
                printf "\n"
                echo "set              version            (version)"
                echo "set              name               (Application)"
                echo "set              root               /opt/$ name/$ version"
                printf "\n"
                echo "prepend-path      PATH              $ root/bin"
                echo "prepend-path      LIBRARY_PATH      $ root/lib"
            } > /usr/share/Modules/modulefiles/example

        fi

    elif [ "$menu" = "10" ]; then

        # Exit Script
        exit
    fi
done