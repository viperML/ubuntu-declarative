#!/usr/bin/env bash
set -euxo pipefail

grep /mnt /proc/mounts && umount -R /mnt

zfs rollback bigz/ubuntu/usr@empty
zfs rollback bigz/ubuntu/etc@empty
zfs rollback bigz/ubuntu/opt@empty
zfs rollback bigz/ubuntu/var@empty
zfs rollback bigz/ubuntu/boot@empty
zfs rollback bigz/ubuntu/rootfs@empty
