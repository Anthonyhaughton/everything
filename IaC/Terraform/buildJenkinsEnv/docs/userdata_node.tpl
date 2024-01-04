#!/bin/bash

# Jenkins/Java
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo dnf install java-17-amazon-corretto -y

# Git
sudo yum install git -y

# Terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

# Generate SSH key for Jenkins builder and output key to /root/key.txt

# Set the desired key file and passphrase
KEY_FILE="$HOME/.ssh/jenkins_key"
PASSPHRASE=""

# Generate Ed25519 SSH key without user interaction
ssh-keygen -t ed25519 -f "$KEY_FILE" -N "$PASSPHRASE"

cat /$HOME/.ssh/jenkins_key >> /$HOME/key.txt
