#!/bin/bash

ifconfig wlan0 down
iwconfig wlan0 mode monitor
airmon-ng start wlan0
cd /root/src/iSniff-GPS
echo "Run the command below in a separate window:"
echo "cd /root/src/iSniff-GPS && ./manage.py runserver 127.0.0.1:8000"
./run.sh -i wlan0

