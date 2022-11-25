#!/usr/bin/env bash
set -euxo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)"
source "$DIR/common.sh"


zy="zypper --root $M"

mount --types proc /proc $M/proc

if ! $zy repos | grep " oss "; then
    $zy -n addrepo -C http://download.opensuse.org/tumbleweed/repo/oss/ oss
fi

if ! $zy repos | grep " non-oss "; then
    $zy -n addrepo -C http://download.opensuse.org/tumbleweed/repo/non-oss/ non-oss
fi

$zy --gpg-auto-import-keys refresh

$zy -n install -t pattern enhanced_base
