#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; pwd)


docker run \
    --interactive \
    --tty \
    --mount type=bind,source=/mnt,target=/mnt \
    ubuntu:22.04
