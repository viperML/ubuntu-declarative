#!/usr/bin/env bash
set -euxo pipefail

m=/mnt

grep /mnt /etc/mtab && umount -R /mnt

mount -t zfs -o zfsutil tank/ubuntu/rootfs $m

mkdir -p $m/nix
mount -t zfs tank/ubuntu/nix $m/nix

mkdir -p $m/home
mount -t zfs tank/ubuntu/home $m/home

mkdir -p $m/efi
mount /dev/disk/by-label/LINUXESP $m/efi
