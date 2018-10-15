#!/bin/bash

MY_MOUNT_DIR="/mnt"

for MY_PARTITION in `fdisk -l | grep -v swap | egrep -o /dev/sd.[0-9]+` ; do
    mount | grep -q "^$MY_PARTITION"
    if [ $? -eq 1 ] ; then
          blkid $MY_PARTITION
          if [ $? -eq 0 ] ; then
              MOUNTPOINT=$MY_MOUNT_DIR/`echo $MY_PARTITION | egrep -o sd.[0-9]+`
              mkdir -p $MOUNTPOINT
              mount $MY_PARTITION $MOUNTPOINT
          fi
fi

done
