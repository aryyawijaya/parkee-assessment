#!/bin/bash

# Usage:
# ./1.sh DIRECTORY EXTENSION

find_files() {
    # Define directory & extension parameter to variable
    DIRECTORY=$1
    EXTENSION=$2

    # Validate directory
    if [ ! -d "$DIRECTORY" ]; then
        echo "Error: Directory $DIRECTORY does not exist."
        exit 1
    fi

    # Find file with given extension and directory
    find "$DIRECTORY" -type f -name "*.$EXTENSION" -print
}

# Validate number of parameters
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 DIRECTORY EXTENSION"
    exit 1
fi

find_files $1 $2
