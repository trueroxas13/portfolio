#!/bin/bash

#check if open-ssh is installed, if not then install it
./utils/check-install.sh ssh openssh-client

#check if mosh is installed, if not then install it
./utils/check-install.sh mosh mosh

echo "Enter username: "
read username

echo "Enter IP address: "
read address

if ssh -q $username@$address exit; then
	echo "Connection via SSH is successful."
fi

if mosh $username@$address exit; then
	echo "Connection via mosh is successful."
fi

