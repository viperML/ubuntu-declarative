#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd)
pushd $DIR

stages=(stage1 stage2)

for s in ${stages[@]}; do
    dpkg-deb --build --root-owner-group $s
    cp -f "$s.deb" /
done

apt update
apt upgrade --yes

for s in ${stages[@]}; do
    apt install --reinstall ./$s.deb
done

apt autopurge
