#!/bin/bash

# User must provide a passphras
echo "Enter passphrase to for the SSH key : "

#to not display the passphrase to the user when it is being typed (-s).
read -s passphrase 


# If user doesnt enter a passphrase a random one will be generated.
if [ -z "$passphrase" ]; 
then
    passphrase=$(bash utils/generate-pass.sh)
    echo "No passphrase provided, The system will generate a new random one."
fi

# Generate SSH key and map it with a passphrase
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "$passphrase"

echo "SSH key successfully created!"

