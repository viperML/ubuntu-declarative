#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")";cd ..; pwd)

stages=(stage1 stage2 stage3)

for s in ${stages[@]}; do
    dpkg-deb --build --root-owner-group $DIR/$s $s.deb
done

apt install --reinstall --yes ./stage1.deb
apt update
apt upgrade --yes
apt install --reinstall --yes ./stage2.deb
apt install --reinstall --yes ./stage3.deb
apt autopurge
