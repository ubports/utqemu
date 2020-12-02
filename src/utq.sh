#!/bin/bash

# Copyright (C) 2019 UBports Foundation.
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License version 3, as published by
# the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranties of MERCHANTABILITY,
# SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -e

function debug {
    if [ "$UTQ_DEBUG" == "1" ]; then
        echo "$1"
    fi
}

DATA_DIR="${HOME}/.cache/ubuntu-touch-qemu"
if [ ! -z "${SNAP_USER_COMMON}" ]; then
    debug "Is snap, using dir: SNAP_USER_COMMON"
    DATA_DIR="$SNAP_USER_COMMON"
fi
debug "Data dir is $DATA_DIR"

UBPORTS_CI="https://ci.ubports.com/"
AMD64_URL="${UBPORTS_CI}/job/rootfs/job/rootfs-generic-amd64/lastSuccessfulBuild/artifact/ubuntu-touch-mainline-generic-amd64.img.xz"
IMG_FILE_NAME="ubuntu-touch-mainline-generic-amd64.img"
IMG_FILE="${DATA_DIR}/${IMG_FILE_NAME}"

F_WGET="wget"
F_XZ="xz"
F_QEMU="qemu-system-x86_64"
F_SSH="ssh"


if [ ! "$UTQ_STADARD_TOOLS" == "1" ]; then
    if [ -x "$(command -v aria2c)" ]; then
        debug "Using aria2c"
        F_WGET="aria2c"
    fi

    if [ -x "$(command -v pixz)" ]; then
        debug "Using pixz"
        F_XZ="pixz"
    fi

    if [ -x "$(command -v qemu-virgil)" ]; then
        debug "Using qemu-virgil"
        F_QEMU="qemu-virgil"
    fi

    if [ -x "$(command -v sshpass)" ]; then
        debug "Using sshpass"
        F_SSH="sshpass -pphablet ssh"
    fi
fi

function get_img {
    if [ "$F_WGET" == "aria2c" ]; then
        $F_WGET -d "$DATA_DIR" -o "${IMG_FILE_NAME}.xz" ${AMD64_URL}
    else
        $F_WGET -O "${IMG_FILE}.xz" ${AMD64_URL}
    fi
    $F_XZ -d "${IMG_FILE}.xz"
}

function setup {
    if [ ! -d ${DATA_DIR} ]; then
        debug "Making new directory ${DATA_DIR}"
        mkdir -p "${DATA_DIR}"
    fi

    if [ ! -f "${IMG_FILE}" ]; then
        debug "Getting image"
        get_img
    fi
}

function start_qemu {
    exec $F_QEMU \
        -enable-kvm \
        -m 2G \
        -device virtio-vga \
        -display sdl,gl=on \
        -netdev user,id=ethernet.0,hostfwd=tcp::10022-:22 \
        -device rtl8139,netdev=ethernet.0 \
        ${IMG_FILE}
}

function start {
    setup
    start_qemu
}

function create {
    if [ -f "${IMG_FILE}" ]; then
        echo "Ubuntu touch qemu alredy exist!"
        exit 1
    fi
    get_img
}

function delete {
    if [ ! -f "${IMG_FILE}" ]; then
        echo "Ubuntu touch qemu does not exist!"
        exit 1
    fi
    rm ${IMG_FILE}
}

function recreate {
    delete
    create
}

function ssh {
    echo "Password is phablet"
    exec $F_SSH phablet@localhost -p 10022 -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no"
}

function usage {
    echo "Ubuntu touch qemu - usage"
    echo "  utq start    - Stats qemu"
    echo "  utq create   - Creates ubuntu touch qemu"
    echo "  utq recreate - reCreates ubuntu touch qemu"
    echo "  utq delete   - Deletes ubuntu touch qemu"
    echo "  utq ssh      - ssh into running ubuntu touch qemu"
    echo "  Default user:password is phablet:phablet"
}

case $1 in
    "start")
        start
        ;;
    "create")
        create
        ;;
    "recreate")
        recreate
        ;;
    "delete")
        delete
        ;;
    "ssh")
        ssh
        ;;
    *)
        usage
        ;;
esac
