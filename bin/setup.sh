#!/bin/bash

echo "Running apt-get update."
sudo apt-get -qq update
echo "Running apt-get dist-upgrade."
DEBIAN_FRONTEND=noninteractive APT_LISTCHANGES_FRONTEND=none \
    sudo apt \
        -o Dpkg::Options::=--force-confold \
        -o Dpkg::Options::=--force-confdef \
        -y --allow-downgrades --allow-remove-essential --allow-change-held-packages dist-upgrade

# Install tools
sudo apt install -y \
    exfat-fuse \
    libbde-dev \
    libbde-utils \
    pv

