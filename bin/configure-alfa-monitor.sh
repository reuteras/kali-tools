#!/bin/bash

# Run update if clean was run before
sudo apt update

sudo apt install -y realtek-rtl88xxau-dkms
sudo modprobe 88XXau

sudo ip link set wlan0 down
sleep 1
sudo iwconfig wlan0 mode monitor
sudo ip link set wlan0 up
