#!/bin/sh
m=/sysroot

# Wait for zfs
modprobe zfs 2>/dev/null
udevadm settle

mount -t tmpfs none -o defaults,size=4G,mode=0755 $m

# required for usable_root
mkdir $m/proc
mkdir $m/sys
mkdir $m/dev

mkdir $m/usr
mkdir $m/var
mkdir $m/etc

zpool import -N -a

mount -t zfs bigz/ubuntu/usr $m/usr
mount -t zfs bigz/ubuntu/var $m/var
mount -t zfs bigz/ubuntu/etc $m/etc
