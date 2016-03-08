#!/bin/bash

apt-get autoremove && apt-get autoclean && apt-get clean
dd if=/dev/zero of=zero; sync; rm -f zero

