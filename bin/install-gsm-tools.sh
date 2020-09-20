#!/bin/bash

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

cd ~ || exit

if [ ! -d ~/gr-gsm ]; then
    git clone https://git.osmocom.org/gr-gsm
    cd gr-gsm || exit
    mkdir build
    cd build || exit
    cmake ..
    [ ! -e ~/.grc_gnuradio ] && mkdir ~/.grc_gnuradio
    [ ! -e ~/.gnuradio ] && mkdir ~/.gnuradio
    make
    make install
    ldconfig
    cd ~ || exit
fi

if [ ! -d ~/IMSI-catcher ]; then
    git clone https://github.com/Oros42/IMSI-catcher.git
    cd ~ || exit
fi

if [[ "$CREATEDSWAP" == "1" ]]; then
	swapoff ~/swap
	rm ~/swap
fi

