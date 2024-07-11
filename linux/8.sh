#!/bin/bash

# Usage: ./8.sh USERNAME SERVER_IP

test_ssh_connection_to_remote() {
    # Define variable from parameter
    USERNAME=$1
    SERVER_IP=$2

    # SSH to remote server then exit immediately
    ssh -o BatchMode=yes -o ConnectTimeout=5 "$USERNAME@$SERVER_IP" exit

    # Check result of SSH connection
    if [ $? -ne 0 ]; then
        echo "Failed to connect to $USERNAME@$SERVER_IP via SSH."
        exit 1
    fi

    echo "SSH connection to $USERNAME@$SERVER_IP was successful."
}

# Validate number of parameters
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 USERNAME SERVER_IP"
    exit 1
fi

test_ssh_connection_to_remote $1 $2
