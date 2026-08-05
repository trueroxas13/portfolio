#!/bin/bash

# utils/generate-pass.sh

# Ensure pwgen is installed silently
./utils/check-install.sh pwgen pwgen >/dev/null 2>&1

# Generate and print a random password
pwgen -s 12 1
