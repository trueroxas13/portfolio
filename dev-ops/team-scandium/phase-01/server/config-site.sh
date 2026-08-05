#!/bin/bash

# Ensure the script is not run as root
if [[ "$EUID" -eq 0 ]]; then
    echo "ERROR: Do not run this script as root. Use a user with sudo privileges." >&2
    exit 1
fi

USERNAME=$1

if [[ -z "$USERNAME" ]]; then
    echo "Usage: $0 <username>"
    exit 1
fi

# Create a "site" directory in the user's home directory
SITE_DIR="/home/$USERNAME/site"
if [[ ! -d "$SITE_DIR" ]]; then
    sudo mkdir -p "$SITE_DIR" || { echo "Failed to create site directory for $USERNAME"; exit 1; }
    sudo chown "$USERNAME:$USERNAME" "$SITE_DIR" || { echo "Failed to set ownership for $SITE_DIR"; exit 1; }
    echo "Created site directory for $USERNAME."
else
    echo "Site directory already exists for $USERNAME."
fi

# Create a symbolic link to the NGINX web root
NGINX_LINK="/usr/share/nginx/html/$USERNAME"
if [[ ! -L "$NGINX_LINK" ]]; then
    sudo ln -s "$SITE_DIR" "$NGINX_LINK" || { echo "Failed to create symbolic link for $USERNAME"; exit 1; }
    echo "Created symbolic link for $USERNAME."
else
    echo "Symbolic link already exists for $USERNAME."
fi

# Adjust permissions for the home directory to allow NGINX to access "site"
sudo chmod o+rx "/home/$USERNAME" || { echo "Failed to adjust permissions for $USERNAME's home directory"; exit 1; }
sudo chmod o+rx "/home/$USERNAME/site"

echo "Configuration for $USERNAME's website directory is complete."
