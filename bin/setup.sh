#!/bin/bash

echo "Running apt-get update."
apt-get -qq update
echo "Running apt-get dist-upgrade."
apt-get -qq -y --force-yes dist-upgrade

# Install VMware tools
apt-get install -y open-vm-tools-desktop fuse

# Install tools
apt-get install -y libbde-dev libbde-utils exfat-fuse exfat-utils \
    pv ecryptfs-utils

# Make sure pip is up to date
pip install --upgrade pip

# Install tool for Rubber ducky
# Resources http://usbrubberducky.com/#!resources.md
pip install --upgrade ducktoolkit
