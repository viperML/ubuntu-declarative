#!/usr/bin/env bash
set -euxo pipefail

m=/mnt

grep /mnt /etc/mtab && umount -R /mnt

# mount -t tmpfs tmpfs $m
mount -t zfs -o zfsutil bigz/ubuntu/rootfs $m

mkdir -p $m/{efi,usr,var,etc,opt,boot}

mount -t zfs bigz/ubuntu/usr $m/usr
mount -t zfs bigz/ubuntu/var $m/var
mount -t zfs bigz/ubuntu/etc $m/etc
mount -t zfs bigz/ubuntu/opt $m/opt
mount -t zfs bigz/ubuntu/boot $m/boot

mount /dev/disk/by-label/LINUXESP $m/efi
