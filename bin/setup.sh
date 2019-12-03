#!/bin/bash

echo "Running apt-get update."
apt-get -qq update
echo "Running apt-get dist-upgrade."
DEBIAN_FRONTEND=noninteractive APT_LISTCHANGES_FRONTEND=none \
    apt -fuy dist-upgrade

# Install VMware tools
apt install -y open-vm-tools-desktop fuse

# Install tools
apt install -y libbde-dev libbde-utils exfat-fuse exfat-utils pv

# Make sure pip is up to date
# pip install --upgrade pip

# Install tool for Rubber ducky
# Resources http://usbrubberducky.com/#!resources.md
# pip install --upgrade ducktoolkit
