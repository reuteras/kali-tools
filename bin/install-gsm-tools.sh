#!/bin/bash

# Couldn't compile on Rasberry Pi
MEMORY=$(free | grep Mem: | awk '{print $2}' )
SWAP=$(free | grep Swap: | awk '{print $2}' )
CREATEDSWAP=0

if [[ $MEMORY -lt 2097152 ]]; then
	echo "Memory smaller then 2GB. Checking swap."
    if [[ $SWAP -lt 1048576 ]]; then
    	echo "Creating swap in /root/swap."
        if [[ -e /root/swap ]]; then
 			echo "/root/swap exists!"
            exit
        fi
        dd if=/dev/zero of=/root/swap bs=1024 count=1048576
        chmod 0600 /root/swap
        mkswap /root/swap
        swapon /root/swap
		CREATEDSWAP=1
	fi
fi

apt update && apt upgrade -yqq
apt install -yqq \
    autoconf \
    build-essential \
    cmake \
    doxygen \
    git \
    gnuradio-dev \
    gr-osmosdr \
    libcppunit-dev \
    liblog4cpp5-dev \
    libosmocore-devpython-numpy \
    libtool \
    pkg-config \
    python-docutils \
    python-gtk2 \
    python-scapy \
    python-scipy \
    swig

cd /root || exit

if [ ! -d /root/gr-gsm ]; then
    git clone https://git.osmocom.org/gr-gsm
    cd gr-gsm || exit
    mkdir build
    cd build || exit
    cmake ..
    [ ! -e /root/.grc_gnuradio ] && mkdir /root/.grc_gnuradio
    [ ! -e /root/.gnuradio ] && mkdir /root/.gnuradio
    make
    make install
    ldconfig
    cd /root || exit
fi

if [ ! -d /root/IMSI-catcher ]; then
    git clone https://github.com/Oros42/IMSI-catcher.git
    cd /root || exit
fi

if [[ "$CREATEDSWAP" == "1" ]]; then
	swapoff /root/swap
	rm /root/swap
fi

