#!/usr/bin/env bash
set -euxo pipefail

stages=(stage1 stage2)

for s in ${stages[@]}; do
    dpkg-deb --build --root-owner-group $s
    cp -f "$s.deb" /mnt
done

read -p "Run debootstrap? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    debootstrap --variant=minbase jammy /mnt http://archive.ubuntu.com/ubuntu
fi

read -p "Install stages? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker run \
        --interactive \
        --tty \
        --mount type=bind,source=/mnt,target=/mnt \
        --mount type=bind,source=/efi,target=/mnt/efi \
        --env DEBIAN_FRONTEND=noninteractive \
        ubuntu:22.04 \
        chroot /mnt /usr/bin/bash -c "apt install --yes --reinstall /stage1.deb && apt update && apt upgrade -y && apt install --yes --reinstall /stage2.deb"
fi
