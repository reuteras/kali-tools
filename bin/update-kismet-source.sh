#!/bin/bash

# Couldn't compile on Rasberry Pi
MEMORY=$(free | grep Mem: | awk '{print $2}' )
SWAP=$(free | grep Swap: | awk '{print $2}' )
CREATEDSWAP=0

if [[ $MEMORY -lt 2097152 ]]; then
    echo "Memory smaller then 2GB. Checking swap."
    if [[ $SWAP -lt 2097152 ]]; then
        echo "Creating swap in /root/swap."
        if [[ -e /root/swap ]]; then
            echo "/root/swap exists!"
            exit
        fi
        dd if=/dev/zero of=/root/swap bs=1024 count=2097152
        chmod 0600 /root/swap
        mkswap /root/swap
        swapon /root/swap
        CREATEDSWAP=1
    fi
fi

cd /root/kismet || exit
make distclean
git pull
./configure
make
make install
make plugins
make plugins-install
make restricted-plugins
make restricted-plugins-install

if [[ "$CREATEDSWAP" == "1" ]]; then                                                                                                                                                                                                          
    swapoff /root/swap
    rm /root/swap
fi
