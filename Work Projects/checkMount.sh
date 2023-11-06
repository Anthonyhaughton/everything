#!/bin/bash

is_mounted() {
    mount | awk -v DIR="$1" '{if ($3 == DIR) { exit 0}} ENDFILE{exit -1}'
}

{
    if is_mounted "/mnt/dcdata002/rhel_repos"; then
        echo "/mnt/backup already mounted"
    else
        mount /dev/sdc1 /mnt/backup
    fi
}
