#!/bin/bash

# Require sysstat & bc package
echo "Installing dependencies..."
sudo apt install bc sysstat -y
echo ""

# Log file location
LOG_FILE="/var/log/cpu_usage.log"

# Set interval average CPU usage
INTERVAL=60

while true; do
    echo "Getting 1 minute CPU usage..."

    # Get the CPU idle percentage over 1 minute
    IDLE=$(mpstat 1 $INTERVAL | awk '/Average/ {print $12}')

    # Calculate the CPU usage percentage
    CPU_USAGE=$(echo "100 - $IDLE" | bc)

    # Echo the CPU usage percentage
    echo "1 minute CPU usage result: $CPU_USAGE%"

    # If the CPU usage is above 75%, log the information
    if (( $(echo "$CPU_USAGE > 75" | bc -l) )); then
        TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
        LOG_ENTRY="$TIMESTAMP - CPU usage is at $CPU_USAGE%"
        echo "$LOG_ENTRY"

        # Attempt to write to log file and check if successful
        sudo sh -c "echo $LOG_ENTRY >> $LOG_FILE"
        if [ $? -eq 0 ]; then
            echo "Successfully logged: $LOG_ENTRY"
        else
            echo "Error: Failed to write to $LOG_FILE"
        fi
    fi
done
