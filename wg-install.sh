#!/bin/bash

# check for distro

function install_on_debian() {
    sudo sh -c "echo 'deb http://deb.debian.org/debian buster-backports main' >> /etc/apt/sources.list.d/backports.list"
    sudo sh -c "printf 'Package: *\nPin: release a=buster-backports\nPin-Priority: 90\n' >> /etc/apt/preferences.d/limit-backports"

    
}


while [ "$1" != "" ]; do
    case $1 in
    --debian | -d)
        
        ;;
    --show_possible | -sp)
        
        ;;
    *)
        exit 1
        ;;
    esac
    shift
done