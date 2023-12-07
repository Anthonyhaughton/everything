#!/bin/bash

#vars
name=$(hostname)

echo "$name" >> /root/diskCheck.txt
/cm/shared/apps/MegaRAID/storcli/storcli64 show all | grep -i hdd >> /root/diskCheck.txt

#vars
check=$(grep -i hdd /root/diskCheck.txt)

if [ "$check" == *'HDD'* ] && [ "$check" == *'Failed'* ]; then
	
  echo "There is a failed drive on $name."

elif [ "$check" == *'Rbld'* ]; then

  echo "There is a drive rebuilding on $name."

else

  echo "No failed drives detected on $name."
  echo "All drives operational." >> /root/diskCheck.txt

fi
 
echo "" >> /root/diskCheck.txt
