#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; cd ..; pwd)

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

docker run \
    --interactive \
    --tty \
    --mount type=bind,source=/mnt,target=/mnt \
    --env DEBIAN_FRONTEND=noninteractive \
    ubuntu:kinetic \
    chroot /mnt /usr/bin/bash
