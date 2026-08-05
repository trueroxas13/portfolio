#!/bin/bash

# Check if packages are installed 

./utils/check-install.sh nmap nmap
./utils/check-install.sh ip iproute

#Get network details
NETWORK_INFO=$(ip -o -f inet addr show | awk '/scope global/ {print $4}')

if [ -z "$NETWORK_INFO" ]; then
    echo "Network not found"
    exit 1
fi



echo "Scanning network $NETWORK_INFO..."


sudo nmap -sn "$NETWORK_INFO" -oG - | awk '/Host:/{print $2, $3}' | sed 's/(//;s/)//' > discovered_hosts.txt

sudo nmap -sS "$NETWORK_INFO" -oN detailed_scan.txt

# Output summary
echo "Scan completed successfully"



