#!/bin/bash
function gen_server_keys() {
    echo "generating server keys"
}

function gen_client_keys() {
    echo "generating client keys"
}


if [ $# -eq 0 ]; then
    exit 1
fi

while [ "$1" != "" ]; do
    case $1 in
    --server)
        gen_server_keys
        ;;
    --client)
        gen_server_keys
        ;;
    *)
        exit 1
        ;;
    esac
    shift
done



# create dirs
#[[ -d /etc/wireguard/clients ]] || mkdir /etc/wireguard/clients 
#[[ -d /etc/wireguard/server ]] || mkdir /etc/wireguard/servers 



