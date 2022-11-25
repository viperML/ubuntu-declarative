#!/usr/bin/env bash
set -euxo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)"
source "$DIR/common.sh"


grep $M /etc/mtab && umount -R $M

mount -t tmpfs tmpfs $M

mkdir -p $M/{efi,usr,var,etc,opt,boot}

mount -t zfs $ZPOOL/usr $M/usr
mount -t zfs $ZPOOL/var $M/var
mount -t zfs $ZPOOL/etc $M/etc
mount -t zfs $ZPOOL/opt $M/opt
mount -t zfs $ZPOOL/boot $M/boot

mount /dev/disk/by-label/LINUXESP $M/efi

findmnt | grep $M
