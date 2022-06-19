#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")";cd ..; pwd)

read -p "Run debootstrap? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker run \
        --mount type=bind,source=/mnt,target=/mnt \
        --mount type=bind,source=$DIR,target=/mnt/src,readonly \
        --env DEBIAN_FRONTEND=noninteractive \
        ubuntu:kinetic \
        /usr/bin/env bash -c "/mnt/src/bin/debootstrap.sh /mnt"
fi

read -p "Run apply.sh? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker run \
        --mount type=bind,source=/mnt,target=/mnt \
        --mount type=bind,source=$DIR,target=/mnt/src,readonly \
        --env DEBIAN_FRONTEND=noninteractive \
        ubuntu:kinetic \
        chroot /mnt /usr/bin/env bash -c "cd /; /src/bin/apply.sh"
fi
