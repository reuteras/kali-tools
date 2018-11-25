#!/bin/bash

apt update && apt upgrade -yqq
apt install -yqq \
    build-essential \
    git \
    libcap-dev \
    libdw-dev \
    libmicrohttpd-dev \
    libncurses5-dev \
    libnl-3-dev\
    libnl-genl-3-dev \
    libnm-dev \
    libpcap-dev \
    libprotobuf-dev \
    libprotobuf-c-dev \
    libprotoc-dev \
    libsensors4-dev \
    libsqlite3-dev \
    libusb-1.0-0 \
    libusb-1.0-0-dev \
    pkg-config \
    protobuf-compiler \
    protobuf-c-compiler \
    zlib1g-dev \

cd /root || exit

git clone https://www.kismetwireless.net/git/kismet.git
cd kismet || exit
./configure
make
make install
make plugins
make plugins-install
make restricted-plugins
make restricted-plugins-install
