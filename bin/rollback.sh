#!/usr/bin/env bash
set -euxo pipefail

grep /mnt /proc/mounts && umount -R /mnt
zfs rollback bigz/ubuntu/rootfs@empty
