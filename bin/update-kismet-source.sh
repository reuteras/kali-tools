#!/bin/bash

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

