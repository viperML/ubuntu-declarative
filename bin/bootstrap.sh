#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")";cd ..; pwd)

read -p "Debootstrap? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker run \
        --mount type=bind,source=/mnt,target=/mnt \
        --mount type=bind,source=$DIR,target=/mnt/src,readonly \
        --env DEBIAN_FRONTEND=noninteractive \
        ubuntu:kinetic \
        /usr/bin/env bash -c "/mnt/src/bin/debootstrap.sh /mnt"
fi

read -p "Apply stages? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    systemd-nspawn -D /mnt \
        --setenv=PATH=/usr/bin:/usr/sbin:/bin:/sbin \
        --setenv=DEBIAN_FRONTEND=noninteractive \
        --bind-ro="$DIR:/src" \
        --resolv-conf=replace-host \
        /src/bin/apply.sh
fi
#     docker run \
#         --mount type=bind,source=/mnt,target=/mnt \
#         --mount type=bind,source=$DIR,target=/mnt/src,readonly \
#         --env DEBIAN_FRONTEND=noninteractive \
#         --cap-add=SYS_ADMIN \
#         ubuntu:kinetic \
#         chroot /mnt /usr/bin/env bash -c "cd /; /src/bin/apply.sh"
# fi
