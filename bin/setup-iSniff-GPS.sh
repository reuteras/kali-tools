#!/bin/bash

set -e

if [[ ! -d ~/src ]]; then
    mkdir ~/src
fi

if [[ ! -d ~/src/iSniff-GPS ]]; then
    cd ~/src
    git clone https://github.com/hubert3/iSniff-GPS.git
fi

if ! dpkg --status virtualenv > /dev/null 2>&1 ; then
    apt-get install -y virtualenv
fi

if [[ ! -d ~/src/iSniff-GPS/.env ]]; then
    cd ~/src/iSniff-GPS
    virtualenv --no-site-packages .env
    . .env/bin/activate && pip install -U -r requirements.txt
    . .env/bin/activate && ./manage.py syncdb
fi

