#!/bin/bash

# Ensure the script is NOT run as root
if [[ $EUID -eq 0 ]]; then
  echo "ERROR: Do not run this script as root. Use a user with sudo privileges."
  exit 1
fi

# Install OpenSSH Server if not installed
echo "Checking for OpenSSH Server..."
./utils/check-install.sh sshd openssh-server

# Enable and start the SSH service
echo "Enabling and starting the SSH service..."
sudo systemctl enable --now sshd

# Disable root login for SSH
echo "Disabling root login for SSH..."
if sudo grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
  sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
else
  echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config > /dev/null
fi

# Restrict SSH access to the 'clients' group
echo "Configuring SSH to allow only the 'clients' group..."
if ! sudo grep -q "^AllowGroups clients" /etc/ssh/sshd_config; then
  echo "AllowGroups clients" | sudo tee -a /etc/ssh/sshd_config > /dev/null
fi

# Ensure SFTP is enabled
echo "Enabling SFTP..."
if ! sudo grep -q "^Subsystem sftp /usr/libexec/openssh/sftp-server" /etc/ssh/sshd_config; then
  echo "Subsystem sftp /usr/libexec/openssh/sftp-server" | sudo tee -a /etc/ssh/sshd_config > /dev/null
fi

# Restart the SSH service to apply changes
echo "Restarting the SSH service..."
sudo systemctl restart sshd

# Add firewall rules to allow SSH access
echo "Configuring firewall for SSH access..."
sudo firewall-cmd --add-service=ssh --permanent

sudo firewall-cmd --reload

# Display the SSH service status
echo "Displaying SSH service status..."
sudo systemctl status sshd
