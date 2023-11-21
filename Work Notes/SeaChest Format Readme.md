## This guide goes over how to format a HDD's sector size (4Kn or 512e). Depending on the machine you are working on you may not have the correct sector size to be able to operate on that machine.


1. Download File: https://www.seagate.com/support/software/seachest/
2. Navigate to: C:\Users\""\Downloads\SeaChestUtilities\Linux\RAID\x86_64-RAID

## You want the Format Tool "SeaChest_Format_x86_64-redhat-linux_R_RAID"

3. Copy it to the Linux machine you are going to use to change the sector of the drive
4. Make a "SeaChest" folder and mv the zip to it
5. Unzip the file
6. Cat the README.txt as this has the password for the next unzip 
7. Unzip the _R.zip file and paste in the password

## There should be a "SeaChest_Format_x86_64-redhat-linux_R" dir. 

8. Navigate into the folder to use the executable.
9. Run the file with no options to bring up the menu "./SeaChest_Format_x86_64-redhat-linux_R"
10. Run "./SeaChest_Format_x86_64-redhat-linux_R --scan" to view all devices on the machine and also confirm the model, serial, and handle(/dev/sg*) for the drive you are going to format.

## I found out that this tool can show all drive sectors (4Kn/512e) even if your OS doesn't support them. I was trying to find the drive I plugged in with "lsblk", but it wasn't showing up. But with "./SeaChest_Format_x86_64-redhat-linux_R --scan" it came up. The program shows the drives with the Handle using /dev/sg* labels. I also learned this is another way to address storage devices in more uniform way. (https://stackoverflow.com/questions/22189052/raw-hard-disk-acces-dev-sdx-vs-dev-sgy)

11. To make sure your drive can support the Sector Size you want run: ./SeaChest_Format_x86_64-redhat-linux_R --device /dev/<> --showSupportedFormats

## This can brick the drive so make sure the format you want is supported by the drive.

## After confirming the sector size, you can choose to format to 4Kn or 512e:

12. ./SeaChest_Format_x86_64-redhat-linux_R --device /dev/<> --setSectorSize 4096 --confirm this-will-erase-data-and-may-render-the-drive-inoperable (4Kn)

or 

13. ./SeaChest_Format_x86_64-redhat-linux_R --device /dev/<> --setSectorSize 512 --confirm this-will-erase-data-and-may-render-the-drive-inoperable  (512e)

## After it formats you should be all set...

