#!/bin/bash
# Based on instructions on 
# https://docs.docker.com/install/linux/docker-ce/debian/

sudo apt-get update
sudo apt-get remove -f docker docker-engine docker.io
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
if [[ ! -e /etc/apt/sources.list.d/docker.list ]]; then 
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    echo 'deb https://download.docker.com/linux/debian stretch stable' | sudo tee -a /etc/apt/sources.list.d/docker.list
    sudo apt-get update
fi
sudo apt-get install -y docker-ce docker-compose
