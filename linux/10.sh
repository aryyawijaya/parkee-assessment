#!/bin/bash

# Usage: ./10.sh UNIQUE_STRING USERNAME

delete_public_key_on_authorized_keys() {
    # Define variable from parameter
    UNIQUE_STRING=$1
    USERNAME=$2

    # Define home directory from user
    USER_HOME=$(eval echo ~$USERNAME)

    # Check existence authorized_keys file
    AUTHORIZED_KEYS_FILE="$USER_HOME/.ssh/authorized_keys"
    if [ ! -f "$AUTHORIZED_KEYS_FILE" ]; then
        echo "Error: authorized_keys file does not exist for user $USERNAME."
        exit 1
    fi

    # Backup authorized_keys
    cp "$AUTHORIZED_KEYS_FILE" "$AUTHORIZED_KEYS_FILE.bak"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create backup of authorized_keys."
        exit 1
    fi

    # Delete public key that contains UNIQUE_STRING in authorized_keys
    grep -v "$UNIQUE_STRING" "$AUTHORIZED_KEYS_FILE.bak" > "$AUTHORIZED_KEYS_FILE"

    echo "Public key containing string '$UNIQUE_STRING' removed successfully from $AUTHORIZED_KEYS_FILE"

    # Read & write access .ssh/authorized_keys file only to owner (USERNAME)
    chown $USERNAME:$USERNAME "$AUTHORIZED_KEYS_FILE"
    chmod 600 "$AUTHORIZED_KEYS_FILE"
}

# Validate number of parameters
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 UNIQUE_STRING USERNAME"
    exit 1
fi

delete_public_key_on_authorized_keys $1 $2
