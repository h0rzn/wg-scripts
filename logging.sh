#!/bin/bash

function enable_logging() {
    echo 'module wireguard +p' | sudo tee /sys/kernel/debug/dynamic_debug/control
}

function disable_logging() {
    echo 'module wireguard -p' | sudo tee /sys/kernel/debug/dynamic_debug/control
}

function view_logs() {
    sudo dmesg -wH --level=debug | grep wireguard
}

while [ "$1" != "" ]; do
    case $1 in
    --enable | -e)
        enable_logging
        ;;
    --disable | -d)
        disable_logging
        ;;
    --view | -v )
        view_logs
        ;;
    *)
        exit 1
        ;;
    esac
    shift
done