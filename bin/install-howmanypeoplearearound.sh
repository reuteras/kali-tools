#!/bin/bash

set -e

# Make sure tshark is installed (should be)
sudo apt install tshark python3-venv

echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure wireshark-common
sudo usermod -a -G wireshark "${USER:-root}"

if [[ ! -d ~/src ]]; then
    mkdir ~/src
fi

if [[ ! -d ~/src/howmanypeoplearearound ]]; then
    mkdir ~/src/howmanypeoplearearound
    cd ~/src/howmanypeoplearearound || exit
    python3 -m venv venv
    # shellcheck disable=SC1091
    . venv/bin/activate && python -m pip install howmanypeoplearearound
    for file in venv/lib*/python3.*/site-packages/howmanypeoplearearound/__main__.py; do
        sed -i -E "s/tshark, '-I',/tshark,/" "$file"
    done
fi

# Must be the last command
newgrp wireshark
