#!/bin/bash

set -e

if [[ ! -d ~/src ]]; then
    mkdir ~/src
fi

if [[ ! -d ~/src/public_drown_scanner ]]; then
    cd ~/src
    git clone https://github.com/nimia/public_drown_scanner.git
fi

if ! dpkg --status virtualenv > /dev/null 2>&1 ; then
    apt-get install -y virtualenv
fi

if [[ ! -d ~/src/public_drown_scanner/.env ]]; then
    cd ~/src/public_drown_scanner
    virtualenv --no-site-packages .env
    . .env/bin/activate && pip install scapy-ssl_tls enum pycrypto scapy pyasn1
fi

