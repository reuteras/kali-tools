#!/bin/bash
# Install the driver for the Alfa (Realtek RTL88xxAU) card and put wlan0 in
# monitor mode.

set -euo pipefail

# Run update in case clean was run before
sudo apt update

sudo apt install -y realtek-rtl88xxau-dkms
sudo modprobe 88XXau

sudo ip link set wlan0 down
sleep 1
sudo iw dev wlan0 set type monitor
sudo ip link set wlan0 up
