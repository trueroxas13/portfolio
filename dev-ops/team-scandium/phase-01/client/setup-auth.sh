#!/bin/bash

echo "Enter the server username: "
read username

if [ -z "$username" ]; 
then
    echo "Username cant be empty."
    exit 1
fi

echo "Enter the servers IP address: " 
read ipaddress  
if [ -z "$ipaddress" ]; 
then
    echo "iP address cant be empty."
    exit 1
fi

#connect to server command
server_command="$username@$ipaddress"

#path of public SSH 
key_location="$HOME/.ssh/id_ed25519.pub"


if [ ! -f "$key_location" ]; then
    echo "Key does not exist. Generate one..."
    exit 1
fi

# Upload the key to server
echo "Uploading key...$server_command"
ssh-copy-id -i "$key_location" "$server_command"



