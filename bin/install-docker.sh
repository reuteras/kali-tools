#!/bin/bash
# Install Docker from the Kali repositories. Based on
# https://www.kali.org/docs/containers/installing-docker-on-kali/

set -euo pipefail

sudo apt update
sudo apt install -y docker.io docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

echo "Log out and in again to use docker without sudo."
