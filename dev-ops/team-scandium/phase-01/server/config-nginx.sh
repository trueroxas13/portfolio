#!/bin/bash

# Ensure the script is not run as root
if [[ "$EUID" -eq 0 ]]; then
    echo "ERROR: Do not run this script as root. Use a user with sudo privileges." >&2
    exit 1
fi

echo "Checking for NGINX..."

# Install NGINX if it is not installed
./utils/check-install.sh nginx nginx

echo "Configuring..."
# Enable and start the NGINX service
sudo systemctl enable nginx --now || { echo "Failed to enable and start NGINX"; exit 1; }

# Add firewall rules to allow HTTP traffic
sudo firewall-cmd --permanent --add-service=http || { echo "Failed to add firewall rule for HTTP"; exit 1; }
sudo firewall-cmd --reload || { echo "Failed to reload firewall"; exit 1; }

# Display the status of NGINX
sudo systemctl status nginx || { echo "Failed to display NGINX status"; exit 1; }

sudo setenforce 0

sudo cp config/nginx.conf /etc/nginx/nginx.conf

sudo systemctl restart nginx

echo "NGINX setup complete."
