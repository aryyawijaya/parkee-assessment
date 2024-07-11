#!/bin/bash

# Usage: ./16.sh

# Get hostname
HOSTNAME=$(hostname)

# Get current system time
CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')

# Get number of logged in users
USERS_LOGGED_IN=$(who | wc -l)

# Display system information
echo "Hostname: $HOSTNAME"
echo "Current System Time: $CURRENT_TIME"
echo "Users Logged In: $USERS_LOGGED_IN"
