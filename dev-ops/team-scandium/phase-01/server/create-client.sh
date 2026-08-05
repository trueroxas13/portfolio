#!/bin/bash

# Ensure the script is not run as root
if [[ "$EUID" -eq 0 ]]; then
    echo "ERROR: Do not run this script as root. Use a user with sudo privileges." >&2
    exit 1
fi

# Function to create a new user
create_user() {
    local username=$1
    local fullname=$2

    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists. Skipping creation..."
    else
        # Add user and set full name
        sudo useradd -m -c "$fullname" "$username" || { echo "Failed to create user $username"; exit 1; }
        echo "User '$username' created successfully."

        # Generate a random password and set it
        password=$(./utils/generate-pass.sh)
        echo -e "$password\n$password" | sudo passwd "$username" || { echo "Failed to set password for $username"; exit 1; }
        echo "User '$username' now has password: $password"
    fi
    
    #clients group creation
    
    echo "Initializing clients group..."
    
    if grep clients /etc/group > /dev/null 2>&1; then
    	echo "Clients group already initialized!"
    else
    	sudo groupadd -f clients
    	echo "Adding to clients to sudoers..."
    	echo "Generating permissions file..."
    	touch clients | tee | echo "%clients ALL=(ALL:ALL) ALL" >> clients
    	echo "Copying to sudoers directory..."
    	sudo cp clients /etc/sudoers.d/
    	echo "Cleaning up..."
    	rm clients
    fi
    
    # Add the user to the 'clients' group
    sudo usermod -aG clients "$username" || { echo "Failed to add $username to 'clients' group"; exit 1; }
    echo "User '$username' added to 'clients' group."

    # Call config-site.sh to configure the user's website directory
    ./server/config-site.sh "$username" || { echo "Failed to configure website for $username"; exit 1; }
    echo "Website directory configured for $username."
}

# Read users from config/clients.csv
while IFS=',' read -r username fullname; do
    create_user "$username" "$fullname"
done < config/clients.csv

echo "All users have been processed."
