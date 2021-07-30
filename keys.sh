#!/bin/bash

SERVER_KEY_PATH="/home/dst/coding/wg-scripts/server"
CLIENT_KEY_PATH="/home/dst/coding/wg-scripts/client"

function gen_server_keys() {
    [[ -d $SERVER_KEY_PATH ]] || mkdir $SERVER_KEY_PATH
    priv=$(gen_priv_key)
    pub=$(derive_pub_key $priv)

    # generate files
    priv_key_f="$SERVER_KEY_PATH/private.key"
    pub_key_f="$SERVER_KEY_PATH/public.key"
    
    gen_key_file $priv_key_f $priv
    gen_key_file $pub_key_f $pub
}

function gen_client_keys() {
    [[ -d $CLIENT_KEY_PATH ]] || mkdir $CLIENT_KEY_PATH
    priv=$(gen_priv_key)
    pub=$(derive_pub_key $priv)

    FNAME_INP=$1
    if [[ ${#FNAME_INP} -eq 0 ]]; then
        FNAME="client1"
        echo "yes"
    else
        FNAME=$1
        echo "no"
    fi 

    priv_key_f="$CLIENT_KEY_PATH/$FNAME"
    priv_key_f+="_private.key"
    pub_key_f="$CLIENT_KEY_PATH/$FNAME"
    pub_key_f+="_public.key"


    gen_key_file $priv_key_f $priv
    gen_key_file $pub_key_f $pub
}

# $1: name, $2: content
function gen_key_file() {
    FNAME=$1
    CONTENT=$2
    if [[ ${#FNAME} -gt 1 ]]; then
        touch $FNAME 
        echo $CONTENT > $FNAME

        if [[ ${#CONTENT} -eq 44 ]]; then
            chmod 600 $FNAME
            echo $(date) $FNAME "created"
        else 
            echo "wrong key length"
            exit 1
        fi 
    else 
        echo "name length is too low"
        exit 1
    fi  
}

function gen_priv_key() { 
    key=$(wg genkey)
    echo $key
}


function derive_pub_key() {
    key=$(echo $1 | wg pubkey)
    echo $key
}


if [ $# -eq 0 ]; then
    exit 1
fi

while [ "$1" != "" ]; do
    case $1 in
    --server | -s)
        gen_server_keys
        ;;
    --client | -c)
        shift 
        CLIENT_NAME=$1
        gen_client_keys $CLIENT_NAME 
        ;;
    *)
        exit 1
        ;;
    esac
    shift
done