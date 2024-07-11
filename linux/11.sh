#!/bin/bash

# Usage: ./11.sh ACTION SERVICE_NAME

print_usage() {
    echo "Usage: $0 ACTION SERVICE_NAME"
    echo "Actions: start, stop, status"
}

manage_service() {
    # Define variable from parameter
    ACTION=$1
    SERVICE_NAME=$2

    # Run service action
    case "$ACTION" in
        start)
            echo "Starting service $SERVICE_NAME..."
            sudo systemctl start "$SERVICE_NAME"
            if [ $? -ne 0 ]; then
                echo "Failed to start service $SERVICE_NAME."
                exit 1
            fi
            echo "Service $SERVICE_NAME started successfully."
            ;;
        stop)
            echo "Stopping service $SERVICE_NAME..."
            sudo systemctl stop "$SERVICE_NAME"
            if [ $? -ne 0 ]; then
                echo "Failed to stop service $SERVICE_NAME."
                exit 1
            fi
            echo "Service $SERVICE_NAME stopped successfully."
            ;;
        status)
            echo "Checking status of service $SERVICE_NAME..."
            sudo systemctl status "$SERVICE_NAME"
            ;;
        *)
            echo "Invalid action: $ACTION"
            print_usage
            exit 1
            ;;
    esac
}

# Validate number of parameters
if [ "$#" -ne 2 ]; then
    print_usage
    exit 1
fi

manage_service $1 $2
