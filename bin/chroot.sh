#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; cd ..; pwd)

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

systemd-nspawn -D /mnt \
    --setenv=PATH=/usr/bin:/usr/sbin:/bin:/sbin \
    --bind-ro="$DIR:/src" \
    --resolv-conf=replace-host
