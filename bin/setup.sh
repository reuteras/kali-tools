#!/bin/bash

apt-get update 

DEBIAN_FRONTEND=noninteractive APT_LISTCHANGES_FRONTEND=none \
    apt-get \
    -o Dpkg::Options::="--force-confnew --force-confdef" \
    --force-yes \
    -fuy \
    dist-upgrade

# Install Vmware tools
apt-get install -y open-vm-tools-desktop fuse

# Install tools
apt-get install -y libbde-dev libbde-utils exfat-fuse exfat-utils

# Make sure pip is up to date
pip install --upgrade pip

# Install tool for Rubber ducky
# Resources http://usbrubberducky.com/#!resources.md
pip install --upgrade ducktoolkit
