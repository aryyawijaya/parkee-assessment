#!/bin/bash

# Usage: ./9.sh PUBLIC_KEY_FILE USERNAME

copy-public-key-to-user() {
    # Define variable from parameter
    PUBLIC_KEY_FILE=$1
    USERNAME=$2

    # Check existence pubilc key file
    if [ ! -f "$PUBLIC_KEY_FILE" ]; then
        echo "Error: Public key file $PUBLIC_KEY_FILE does not exist."
        exit 1
    fi

    # Define home directory from user
    USER_HOME="$(eval echo ~$USERNAME)"

    # Check existence ~/.ssh directory, create if not exist
    if [ ! -d "$USER_HOME/.ssh" ]; then
        echo "Directory $USER_HOME/.ssh does not exist. Creating it..."
        mkdir -p "$USER_HOME/.ssh"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to create directory $USER_HOME/.ssh."
            exit 1
        fi

        # Full access (rwx) .ssh only to owner (USERNAME)
        chown $USERNAME:$USERNAME "$USER_HOME/.ssh"
        chmod 700 "$USER_HOME/.ssh"
    fi

    # Add public key to authorized_keys
    cat "$PUBLIC_KEY_FILE" >> "$USER_HOME/.ssh/authorized_keys"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to add public key to $USER_HOME/.ssh/authorized_keys"
        exit 1
    fi
    echo "Public key added successfully to $USER_HOME/.ssh/authorized_keys"

    # Read & write access .ssh/authorized_keys file only to owner (USERNAME)
    chown $USERNAME:$USERNAME "$USER_HOME/.ssh/authorized_keys"
    chmod 600 "$USER_HOME/.ssh/authorized_keys"
}

# Validate number of parameters
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 PUBLIC_KEY_FILE USERNAME"
    exit 1
fi

copy-public-key-to-user $1 $2
