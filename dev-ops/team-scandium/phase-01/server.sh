#!/bin/bash

# Load configuration
SERVER_CONFIG="config/server.csv"
CLIENTS_CONFIG="config/clients.csv"

# Function to install Fastfetch and display system info
fetch_info() {
    ./utils/check-install.sh fastfetch fastfetch
    fastfetch
}

# Ensure NGINX is installed and running using external script
setup_nginx() {
    echo "Ensuring NGINX is installed and running..."
    ./server/config-nginx.sh || { echo "NGINX setup failed. Please check the logs."; exit 1; }
    echo "NGINX setup is complete."
}


# Set server hostname
set_hostname() {
    local hostname=$(awk -F, 'NR==2 {print $1}' "$SERVER_CONFIG")
    sudo hostnamectl set-hostname "$hostname"
    echo "Hostname set to $hostname"
}

# Create client user accounts
create_client_accounts() {
    while IFS=, read -r username fullname email hostname ipaddress; do
        echo "Setting up user: $username"
        ./server/create-client.sh "$username" "$fullname"
    done < <(tail -n +2 "$CLIENTS_CONFIG")
}

# Handle missing symbolic links and permissions for client sites
validate_client_sites() {
    while IFS=, read -r username fullname email hostname ipaddress; do
        local site_dir="/home/$username/site"
        local link_dir="/usr/share/nginx/html/$username"

        # Ensure site directory exists
        if [ ! -d "$site_dir" ]; then
            echo "Creating site directory for $username..."
            sudo mkdir -p "$site_dir"
            sudo chmod -R 755 "$site_dir"
            echo "Site directory created and permissions set for $username."
        fi

        # Ensure symbolic link exists
        if [ ! -L "$link_dir" ]; then
            echo "Creating symbolic link for $username..."
            sudo ln -s "$site_dir" "$link_dir"
            echo "Symbolic link created for $username."
        fi
    done < <(tail -n +2 "$CLIENTS_CONFIG")
}

# Configure SSH and Mosh
configure_remote_access() {
    ./server/config-sshd.sh
    ./server/config-mosh.sh
}

# Main execution
main() {
    echo "Starting server setup..."
    configure_remote_access
    setup_nginx
    set_hostname
    create_client_accounts
    validate_client_sites
    set_selinux_context
    fetch_info
    echo "Server setup completed successfully!"
}

main
