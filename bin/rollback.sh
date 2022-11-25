#!/usr/bin/env bash
set -euxo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)"
source "$DIR/common.sh"

if grep $M /proc/mounts; then
    umount -R $M
    was_mounted=1
else
    was_mounted=0
fi

zfs rollback $ZPOOL/usr@empty
zfs rollback $ZPOOL/etc@empty
zfs rollback $ZPOOL/opt@empty
zfs rollback $ZPOOL/var@empty
zfs rollback $ZPOOL/boot@empty

if [[ $was_mounted -eq 1 ]]; then
    exec "$DIR/mount.sh"
fi
