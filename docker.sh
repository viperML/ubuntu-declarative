#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd)

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

docker run \
    --interactive \
    --tty \
    --mount type=bind,source=/mnt,target=/mnt \
    --mount type=bind,source=/efi,target=/mnt/efi \
    ubuntu:22.04 \
    chroot /mnt /usr/bin/bash
