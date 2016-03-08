#!/bin/bash

if [[ -e ~/kali-tools/.bash_aliases ]]; then
    . ~/kali-tools/.bash_aliases
    apt-get autoremove && apt-get autoclean && apt-get clean && zerodisk
else    
    apt-get autoremove && apt-get autoclean && apt-get clean
fi

