#!/bin/bash

ifconfig wlan0 down
iwconfig wlan0 mode monitor
airmon-ng start wlan0
cd /root/src/iSniff-GPS || exit 1
# shellcheck disable=SC1091
. .env/bin/activate && ./run.sh -i wlan0
