#!/bin/bash

# Usage: ./6.sh TARGET_DIRECTORY

create-ssh-key-pair() {
    # Define variable
    TARGET_DIR=$1
    KEY_NAME="id_rsa"

    # Check target directory, create if not exist
    if [ ! -d "$TARGET_DIR" ]; then
        echo "Directory $TARGET_DIR does not exist. Creating it..."
        mkdir -p "$TARGET_DIR"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to create directory $TARGET_DIR."
            exit 1
        fi
    fi

    # Create SSH key pair
    ssh-keygen -t rsa -b 4096 -f "$TARGET_DIR/$KEY_NAME" -N ""

    # Validate creating SSH key pair
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create SSH key pair."
        exit 1
    fi

    echo "SSH key pair created successfully in $TARGET_DIR"
}

# Validate number of input parameters
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 TARGET_DIRECTORY"
    exit 1
fi

create-ssh-key-pair $1
