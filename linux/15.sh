#!/bin/bash

# Usage: ./15.sh

# Required packages
sudo apt install mailutils -y

# Email settings
EMAIL="email@emai.com"
SUBJECT="Disk Usage Alert"

# Threshold for disk usage
THRESHOLD=80

# Check disk usage every 60 seconds
INTERVAL=60

while true; do
    # Get disk usage percentage for the root partition
    DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

    echo "Disk usage result: $DISK_USAGE%"

    # If the disk usage is above the threshold, send a notification
    if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
        TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
        MESSAGE="Warning: Disk usage is at ${DISK_USAGE}% as of ${TIMESTAMP}"

        # Send email notification
        if echo "$MESSAGE" | mail -s "$SUBJECT" $EMAIL; then
            echo "Notification sent: $MESSAGE"
        else
            echo "Error: Failed to send notification"
        fi
    fi

    # Wait for the specified interval before checking again
    sleep $INTERVAL
done
