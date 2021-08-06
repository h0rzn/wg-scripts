#!/bin/bash

# check for distro

function install_on_debian() {
    sh -c "echo 'deb http://deb.debian.org/debian buster-backports main' >> /etc/apt/sources.list.d/backports.list"
    sh -c "printf 'Package: *\nPin: release a=buster-backports\nPin-Priority: 90\n' >> /etc/apt/preferences.d/limit-backports"
    apt update
    apt install wireguard --assume-yes

    apt install wireguard-dkms wireguard-tools linux-headers-$(uname -r) --assume-yes
    
}


while [ "$1" != "" ]; do
    case $1 in
    --debian | -d)
        install_on_debian
        ;;
    --show_possible | -sp)
        
        ;;
    *)
        exit 1
        ;;
    esac
    shift
done
