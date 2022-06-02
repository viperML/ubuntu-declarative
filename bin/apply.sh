#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")";cd ..; pwd)

stages=(stage1 stage2)

for s in ${stages[@]}; do
    dpkg-deb --build --root-owner-group $DIR/$s $s.deb
done

apt update
apt upgrade --yes

for s in ${stages[@]}; do
    apt install --reinstall --yes ./$s.deb
done

apt autopurge
