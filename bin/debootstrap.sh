#!/usr/bin/env bash
set -euxo pipefail

apt update
apt install --yes debootstrap
debootstrap --variant=minbase kinetic "${@}" http://archive.ubuntu.com/ubuntu
