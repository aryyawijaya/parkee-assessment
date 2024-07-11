#!/bin/bash

# Usage: ./4.sh SOURCE_DIRECTORY BACKUP_DIRECTORY

backup_directory() {
    # Define variable from parameter
    SOURCE_DIRECTORY=$1
    BACKUP_DIRECTORY=$2
    TIMESTAMP=$(date +"%Y%m%d%H%M%S")
    BACKUP_FILE="backup_$TIMESTAMP.tar.gz"

    # Validate source directory
    if [ ! -d "$SOURCE_DIRECTORY" ]; then
        echo "Error: Source directory $SOURCE_DIRECTORY does not exist."
        exit 1
    fi

    # Validate backup directory
    if [ ! -d "$BACKUP_DIRECTORY" ]; then
        echo "Error: Backup location $BACKUP_DIRECTORY does not exist."
        exit 1
    fi

    # Backup and compress
    tar -czf "$BACKUP_DIRECTORY/$BACKUP_FILE" -C "$SOURCE_DIRECTORY" .

    # Validate backup and compress
    if [ $? -ne 0 ]; then
        echo "Backup and compression failed."
        exit 1
    fi
    echo "Backup and compression successful. Backup file created at $BACKUP_DIRECTORY/$BACKUP_FILE"
}

cleanup_old_backups() {
    # Define variable from parameter
    BACKUP_DIRECTORY=$1

    # Delete backup that older than 7 days
    find "$BACKUP_DIRECTORY" -name "backup_*.tar.gz" -type f -mtime +7 -exec rm -f {} \;

    # Validate deleting backup files
    if [ $? -ne 0 ]; then
        echo "Failed to delete old backups."
        exit 1
    fi

    echo "Old backups deleted successfully."
}

# Validate number of parameters
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 SOURCE_DIRECTORY BACKUP_DIRECTORY"
    exit 1
fi

backup_directory $1 $2

cleanup_old_backups $2
