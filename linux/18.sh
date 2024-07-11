#!/bin/bash

# Usage: ./18.sh

# Create netplan configuration file for eth0
sudo sh -c "cat << EOF > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: no
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF"

# Apply netplan configuration
sudo netplan apply

if [[ $? -ne 0 ]]; then
	echo "Failed to apply netplan configuration"
	exit 1
fi

echo "Netplan configuration successfully applied"
