#!/bin/bash

# Usage: ./17.sh

# Allow all output connection
sudo iptables -A OUTPUT -j ACCEPT

# Allow input connection to port 22 (SSH), 80 (HTTP), dan 443 (HTTPS)
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Deny all other input connection
sudo iptables -A INPUT -j DROP
