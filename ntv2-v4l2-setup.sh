#!/bin/bash

# ntv2-v4l2-setup.sh
# This script installs and sets up the NTV2 V4L2/ALSA driver for AJA Corvid 88 on Ubuntu.
# Ensure you run this script with sudo or as root.

# Function to print messages
print_message() {
    echo -e "\e[32m$1\e[0m"
}

# Function to print errors
print_error() {
    echo -e "\e[31m$1\e[0m" >&2
}

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
   print_error "This script must be run as root. Use sudo or switch to the root user."
   exit 1
fi

print_message "Updating package list and upgrading existing packages..."
apt update && apt upgrade -y

print_message "Installing required packages..."
apt install -y git build-essential linux-headers-$(uname -r) v4l-utils

# Define the repository URL and target directory
REPO_URL="https://github.com/aja-video/ntv2-v4l2.git"
TARGET_DIR="$HOME/ntv2-v4l2"

print_message "Cloning the ntv2-v4l2 repository..."
if git clone "$REPO_URL" "$TARGET_DIR"; then
    print_message "Repository cloned successfully."
else
    print_error "Failed to clone the repository. Exiting."
    exit 1
fi

# Change to the driver directory
cd "$TARGET_DIR/driver" || { print_error "Failed to enter the driver directory. Exiting."; exit 1; }

print_message "Building the driver..."
if make; then
    print_message "Driver built successfully."
else
    print_error "Driver build failed. Exiting."
    exit 1
fi

print_message "Loading the driver..."
if sudo ./load; then
    print_message "Driver loaded successfully."
else
    print_error "Failed to load the driver. Exiting."
    exit 1
fi

print_message "Verifying the installation..."
if v4l2-ctl --list-devices; then
    print_message "Installation verified. The following video devices are available:"
    v4l2-ctl --list-devices
else
    print_error "Failed to list video devices. Something went wrong."
    exit 1
fi

print_message "Checking if the driver is loaded..."
if lsmod | grep ntv2video; then
    print_message "The ntv2video driver is loaded successfully."
else
    print_error "The ntv2video driver is not loaded. Exiting."
    exit 1
fi

print_message "Setup completed successfully."

# Exit the script
exit 0
