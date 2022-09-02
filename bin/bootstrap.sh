#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname $BASH_SOURCE)"; cd ..; pwd)
SRC="/src"
M="/mnt"

read -p "Debootstrap? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker run \
        --mount type=bind,source="$M",target="$M" \
        --mount type=bind,source="$DIR",target="$M$SRC",readonly \
        --env DEBIAN_FRONTEND=noninteractive \
        --cap-add=SYS_ADMIN \
        ubuntu:kinetic \
        /usr/bin/env bash -c "$M$SRC/bin/debootstrap.sh $M"
fi

read -p "Apply stages? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    systemd-nspawn -D "$M" \
        --setenv=PATH=/usr/bin:/usr/sbin:/bin:/sbin \
        --setenv=DEBIAN_FRONTEND=noninteractive \
        --bind-ro="$DIR:$SRC" \
        --resolv-conf=replace-host \
        "$SRC/bin/apply.sh"
fi

read -p "Rebuild initrd? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    systemd-nspawn -D "$M" \
        --setenv=PATH=/usr/bin:/usr/sbin:/bin:/sbin \
        --setenv=DEBIAN_FRONTEND=noninteractive \
        --bind-ro="$DIR:$SRC" \
        --resolv-conf=replace-host \
        /usr/bin/legatum-kernel
fi
