#!/bin/bash

# MegaRAID application is needed. This script is put on the host machines to check locally. Place this script on the machine in /root and you can
# run it remotely if you have numerous machines using the checkFailedDrive.sh script.

#vars
name=$(hostname)

echo "$name" >> /root/diskCheck.txt
/cm/shared/apps/MegaRAID/storcli/storcli64 show all | grep -i hdd >> /root/diskCheck.txt

#vars
check=$(grep -i hdd /root/diskCheck.txt)

if [[ $check == *'HDD'* ]]; then

  echo "There is a failed drive."

else

  echo "No failed drives detected"
  echo "All drives operational" >> /root/diskCheck.txt

fi

echo "" >> /root/diskCheck.txt
echo "" >> /root/diskCheck.txt
echo "" >> /root/diskCheck.txt