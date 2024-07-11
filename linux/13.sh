#!/bin/bash

# Usage: ./13.sh PYTHON_SCRIPT SERVICE_NAME

create_python_systemd_service() {
    # Define variable from parameter
    PYTHON_SCRIPT=$1
    SERVICE_NAME=$2

    # Validate file
    if [ ! -f "$PYTHON_SCRIPT" ]; then
        echo "Error: Python script $PYTHON_SCRIPT does not exist."
        exit 1
    fi
    
    # Get the absolute path of the Python script and its directory
    ABS_PYTHON_SCRIPT=$(realpath "$PYTHON_SCRIPT")
    SCRIPT_DIR=$(dirname "$ABS_PYTHON_SCRIPT")

    # Create unit file systemd
    SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"

    sudo sh -c "echo '[Unit]
    Description=Run Python Script as a Service
    After=network.target

    [Service]
    ExecStart=/usr/bin/python3 $PYTHON_SCRIPT
    Restart=always
    User=$(whoami)
    WorkingDirectory=$SCRIPT_DIR

    [Install]
    WantedBy=multi-user.target' > $SERVICE_FILE"

    # Set permission unit file systemd
    sudo chmod 644 $SERVICE_FILE

    # Reload systemd
    sudo systemctl daemon-reload

    # Enable service
    sudo systemctl enable $SERVICE_NAME.service

    echo "Service $SERVICE_NAME created and enabled successfully."

    # Start service
    sudo systemctl start $SERVICE_NAME.service

    # Status service
    sudo systemctl status $SERVICE_NAME.service
}

# Validate number of parameters
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 PYTHON_SCRIPT SERVICE_NAME"
    exit 1
fi

create_python_systemd_service $1 $2
