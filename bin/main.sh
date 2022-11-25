#!/usr/bin/env bash
set -euxo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)"
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")"; cd ..; pwd)"
source "$DIR/common.sh"

if ! grep $M /proc/mounts; then
    exit 1
fi


read -p "Bootstrap? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker run \
        --mount type=bind,source=$M,target=$M \
        --mount type=bind,source="$SRC",target=$M/src,readonly \
        --cap-add=SYS_ADMIN \
        opensuse/tumbleweed \
        "$M/src/bin/bootstrap.sh"
fi

# read -p "Apply stages? [y/N] " -n 1 -r
# if [[ $REPLY =~ ^[Yy]$ ]]; then
#     systemd-nspawn -D "$M" \
#         --setenv=PATH=/usr/bin:/usr/sbin:/bin:/sbin \
#         --setenv=DEBIAN_FRONTEND=noninteractive \
#         --bind-ro="$DIR:$SRC" \
#         --resolv-conf=replace-host \
#         "$SRC/bin/apply.sh"
# fi

# read -p "Rebuild initrd? [y/N] " -n 1 -r
# if [[ $REPLY =~ ^[Yy]$ ]]; then
#     systemd-nspawn -D "$M" \
#         --setenv=PATH=/usr/bin:/usr/sbin:/bin:/sbin \
#         --setenv=DEBIAN_FRONTEND=noninteractive \
#         --bind-ro="$DIR:$SRC" \
#         --resolv-conf=replace-host \
#         /usr/bin/legatum-kernel
# fi
