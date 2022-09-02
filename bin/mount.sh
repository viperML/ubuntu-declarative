#!/usr/bin/env bash
set -euxo pipefail

m=/mnt

grep /mnt /etc/mtab && umount -R /mnt

mount -t zfs -o zfsutil bigz/ubuntu/rootfs $m

mkdir -p $m/efi
mount /dev/disk/by-label/LINUXESP $m/efi
