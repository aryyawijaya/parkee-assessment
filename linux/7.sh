#!/bin/bash

# Usage: ./7.sh PUBLIC_KEY_FILE USERNAME SERVER_IP

copy-ssh-public-key-to-remote() {
    # Define variable from parameter
    PUBLIC_KEY_FILE=$1
    USERNAME=$2
    SERVER_IP=$3

    # Check existence file public key
    if [ ! -f "$PUBLIC_KEY_FILE" ]; then
        echo "Error: Public key file $PUBLIC_KEY_FILE does not exist."
        exit 1
    fi

    # Copy public key to remote server
    ssh-copy-id -i "$PUBLIC_KEY_FILE" "$USERNAME@$SERVER_IP"

    # Check copy process
    if [ "$?" -ne 0 ]; then
        echo "Error: Failed to copy public key to $USERNAME@$SERVER_IP"
        exit 1
    fi

    echo "Public key copied successfully to $USERNAME@$SERVER_IP"
}

# Validate number of parameters
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 PUBLIC_KEY_FILE USERNAME SERVER_IP"
    exit 1
fi

copy-ssh-public-key-to-remote $1 $2 $3
