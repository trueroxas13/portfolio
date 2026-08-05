#!/bin/bash

# utils/check-install.sh

command_name=$1
package_name=$2

# Check if the command exists
if ! command -v "$command_name" &> /dev/null; then
    echo "$command_name is not installed. Installing $package_name..."
    sudo dnf install -y "$package_name"
else
    echo "$package_name is already installed."
fi
