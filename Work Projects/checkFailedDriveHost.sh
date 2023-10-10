#!/bin/bash

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