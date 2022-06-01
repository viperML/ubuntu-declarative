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
