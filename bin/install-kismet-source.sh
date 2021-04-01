#!/bin/bash
# https://www.kali.org/news/kali-on-krack/

if [[ -e /etc/NetworkManager/NetworkManager.conf ]]; then
    if ! grep "unmanaged-devices=interface-name:wlan0" /etc/NetworkManager/NetworkManager.conf ; then
        cat << EOF >> /etc/NetworkManager/NetworkManager.conf
[keyfile]
unmanaged-devices=interface-name:wlan0
unmanaged-devices=interface-name:wlan1
EOF
        systemctl restart NetworkManager
    fi
fi

# Couldn't compile on Rasberry Pi
MEMORY=$(free | grep Mem: | awk '{print $2}' )
SWAP=$(free | grep Swap: | awk '{print $2}' )
CREATEDSWAP=0

if [[ $MEMORY -lt 2097152 ]]; then
	echo "Memory smaller then 2GB. Checking swap."
    if [[ $SWAP -lt 1048576 ]]; then
    	echo "Creating swap in ~/swap."
        if [[ -e ~/swap ]]; then
            # shellcheck disable=SC2088
 			echo "~/swap exists!"
            exit
        fi
        dd if=/dev/zero of=~/swap bs=1024 count=1048576
        chmod 0600 ~/swap
        mkswap ~/swap
        swapon ~/swap
		CREATEDSWAP=1
	fi
fi

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
    python3-setuptools \
    zlib1g-dev \

cd ~ || exit

git clone https://www.kismetwireless.net/git/kismet.git
cd kismet || exit
./configure
make
make install
make plugins
make plugins-install
make restricted-plugins
make restricted-plugins-install

if [[ "$CREATEDSWAP" == "1" ]]; then
	swapoff ~/swap
	rm ~/swap
fi

