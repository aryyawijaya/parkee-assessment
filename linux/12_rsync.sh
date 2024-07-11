#!/bin/bash

# Usage: ./12_rsync SOURCE_FILE USERNAME SERVER_IP
# Note: user required access to rwx home directory

copy_with_rsync() {
    # Define variable from paramter
    SOURCE_FILE=$1
    USERNAME=$2
    SERVER_IP=$3

    # Validate file
    if [ ! -f "$SOURCE_FILE" ]; then
        echo "Error: Source file $SOURCE_FILE does not exist."
        exit 1
    fi

    # Copy file to remote using rsync
    rsync -vz "$SOURCE_FILE" "$USERNAME@$SERVER_IP:~"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to sync file $SOURCE_FILE to $USERNAME@$SERVER_IP:~"
        exit 1
    fi
    echo "File $SOURCE_FILE synced successfully to $USERNAME@$SERVER_IP:~"
}

# Validate number of parameters
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 SOURCE_FILE USERNAME SERVER_IP"
    exit 1
fi

copy_with_rsync $1 $2 $3
