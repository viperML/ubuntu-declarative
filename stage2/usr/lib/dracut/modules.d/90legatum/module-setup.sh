#!/usr/bin/env bash
# shellcheck disable=SC2154

check() {
    return 0
}

depends() {
    return 0
}

installkernel() {
    return 0
}

install() {
    # ZFS module is prio 98
    inst_hook mount 20 "${moddir}/legatum-mount.sh"
}
