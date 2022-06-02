#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")";cd ..; pwd)

read -p "Run debootstrap? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    debootstrap --variant=minbase jammy /mnt http://archive.ubuntu.com/ubuntu
fi

read -p "Run apply.sh? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker run \
        --interactive \
        --tty \
        --mount type=bind,source=/mnt,target=/mnt \
        --mount type=bind,source=$DIR,target=/mnt/src,readonly \
        --env DEBIAN_FRONTEND=noninteractive \
        ubuntu:22.04 \
        chroot /mnt /usr/bin/bash -c "cd /; /src/bin/apply.sh"
fi
