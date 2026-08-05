#!/bin/bash

# Load configuration
CLIENTS_CONFIG="config/clients.csv"

# Function to install Fastfetch and display system info
fetch_info() {
    ./utils/check-install.sh fastfetch fastfetch
    fastfetch
}

# Set client hostname
set_hostname() {
    local hostname=$(awk -F, -v user="$USER" '$1 == user {print $4}' "$CLIENTS_CONFIG")
    sudo hostnamectl set-hostname "$hostname"
    echo "Hostname set to $hostname"
}

# Test and install remote shell tools
setup_remote_shell() {
    ./client/test-remote.sh
}

# Generate SSH keys and set up authentication
setup_ssh_auth() {
    ./client/create-keys.sh
    ./client/setup-auth.sh
}

# Map local network
map_network() {
    ./client/exec-map.sh
}

# Test web server accessibility
test_web_server() {
    ./client/test-web.sh
}

# Initialize and publish personal website
setup_website() {
    ./client/init-site.sh
    ./client/publish-site.sh
}

# Main execution
main() {
    map_network
    set_hostname
    setup_remote_shell
    setup_ssh_auth
    test_web_server
    setup_website
    fetch_info
}

main
