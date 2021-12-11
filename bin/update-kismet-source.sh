#!/bin/bash

PATH=/usr/bin:/bin:/usr/sbin:/sbin

# Couldn't compile on Rasberry Pi
MEMORY=$(free | grep Mem: | awk '{print $2}' )
SWAP=$(free | grep Swap: | awk '{print $2}' )
CREATEDSWAP=0

if [[ $MEMORY -lt 2097152 ]]; then
    echo "Memory smaller then 2GB. Checking swap."
    if [[ $SWAP -lt 2097152 ]]; then
        echo "Creating swap in ~/swap."
        if [[ -e ~/swap ]]; then
            # shellcheck disable=SC2088
            echo "~/swap exists!"
            exit
        fi
        dd if=/dev/zero of=~/swap bs=1024 count=2097152
        chmod 0600 ~/swap
        mkswap ~/swap
        swapon ~/swap
        CREATEDSWAP=1
    fi
fi

if ! grep kali-rolling /etc/debian_version > /dev/null ; then
    VERSION="4.1.6"
    if ! strings /usr/local/lib/libwebsockets.a | grep "$VERSION-v$VERSION" > /dev/null ; then 
        cd /tmp || true
        git clone https://github.com/warmcat/libwebsockets.git
        cd libwebsockets || exit
        # Ugly temp hack
        git checkout "v$VERSION"
        apt install -yqq cmake libssl-dev
        mkdir build
        cd build || exit
        cmake ..
        make
        make install
        rm -rf /tmp/libwebsockets
    fi
fi

cd || exit

[[ ! -e kismet ]] && git clone https://www.kismetwireless.net/git/kismet.git
cd ~/kismet || exit
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
    swapoff ~/swap
    rm ~/swap
fi
