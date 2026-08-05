#!/bin/bash

# Ensure the script is not run as root
if [[ "$EUID" -eq 0 ]]; then
    echo "ERROR: Do not run this script as root. Use a user with sudo privileges." >&2
    exit 1
fi

# Install Mosh
echo "Checking for Mosh..."
./utils/check-install.sh mosh mosh

# Copy the Mosh XML configuration to the firewall
echo "Configuring firewall for Mosh..."
sudo cp config/mosh.xml /etc/firewalld/services/mosh.xml

# Reload the firewall to recognize the new service
echo "Reloading firewall services..."
sudo firewall-cmd --reload

# Add the Mosh service to the firewall
echo "Adding Mosh service to the firewall..."
sudo firewall-cmd --add-service=mosh --permanent
sudo firewall-cmd --reload

echo "Mosh installation and configuration completed successfully!"
