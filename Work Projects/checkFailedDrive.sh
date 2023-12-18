#!/bin/bash

# This script uses an array to go though numerous machines and run the checkDish.sh script. All machines will send the reports to a central location
# and clean up after itself.

#vars
todaysDate=$(date +%F)

# MegaRAID does not work on these machines:
## LAAM01
## LAAM04
## ALAM02

clear

machines=( coam01 coam02 dcam01 dcam02 dcam03 dcam04 dcam05 laam05 laam06 laam07 laam08 laam09 )
for machine in "${machines[@]}"
do

    ssh -q $machine /root/checkDisk.sh
    ssh -q $machine cat "/root/diskCheck.txt" >> /reports/diskcheck/$todaysDate.txt
    ssh -q $machine rm -rf /root/diskCheck.txt

done
