#!/bin/bash

# Usage: ./5.sh

update_all_packages() {
    # Define log file
    LOGFILE="/var/log/system_update.log"

    # Choose appropriate package manager
    if [ -x "$(command -v apt)" ]; then
        PACKAGE_MANAGER="apt"
    elif [ -x "$(command -v yum)" ]; then
        PACKAGE_MANAGER="yum"
    elif [ -x "$(command -v dnf)" ]; then
        PACKAGE_MANAGER="dnf"
    else
        sudo sh -c "echo 'No compatible package manager found' | tee -a $LOGFILE"
        exit 1
    fi

    # Add timestamp to log
    sudo sh -c "echo 'Update started at $(date)' | tee -a $LOGFILE"

    # Update packages
    case "$PACKAGE_MANAGER" in
        apt)
            sudo sh -c "echo 'Using apt to update the system...' | tee -a $LOGFILE"
            sudo sh -c "apt update | tee -a $LOGFILE"
            sudo sh -c "apt upgrade -y | tee -a $LOGFILE"
            ;;
        yum)
            sudo sh -c "echo 'Using yum to update the system...' | tee -a $LOGFILE"
            sudo sh -c "yum check-update | tee -a $LOGFILE"
            sudo sh -c "yum update -y | tee -a $LOGFILE"
            ;;
        dnf)
            sudo sh -c "echo 'Using dnf to update the system...' | tee -a $LOGFILE"
            sudo sh -c "dnf check-update | tee -a $LOGFILE"
            sudo sh -c "dnf update -y | tee -a $LOGFILE"
            ;;
        *)
            sudo sh -c "echo 'Unsupported package manager' | tee -a $LOGFILE"
            exit 1
            ;;
    esac

    # Add completed timestamp
    sudo sh -c "echo 'Update completed at $(date)' | tee -a $LOGFILE"
}

update_all_packages
