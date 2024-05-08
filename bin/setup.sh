#!/bin/bash

#
# Functions
#

# Functions to print messages
function info-message() {
    echo "**** INFO: $*"
}

function error-message() {
    (>&2 echo "**** ERROR: $*")
}

function error-exit-message() {
    (>&2 echo "**** ERROR: $*")
    exit 1
}

# Install Google Chrome
function install-google-chrome() {
    if ! dpkg --status google-chrome-stable > /dev/null 2>&1; then
        info-message "Installing Google Chrome."
        wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        # shellcheck disable=SC2024
        sudo dpkg -i google-chrome-stable_current_amd64.deb > /dev/null 2>&1 || true
        # shellcheck disable=SC2024
        sudo apt -qq -f -y install > /dev/null 2>&1
        rm -f google-chrome-stable_current_amd64.deb
    fi
}

info-message "Running apt-get update."
sudo apt-get -qq update
info-message "Running apt-get dist-upgrade."
DEBIAN_FRONTEND=noninteractive APT_LISTCHANGES_FRONTEND=none \
    sudo apt \
    -o Dpkg::Options::=--force-confold \
    -o Dpkg::Options::=--force-confdef \
    -y --allow-downgrades --allow-remove-essential --allow-change-held-packages dist-upgrade

if [[ $(uname -m) == "aarch64" ]]; then
    info-message "Install tools - aarch64"
    sudo DEBIAN_FRONTEND=noninteractive apt -qq install -y \
        chromium \
        exfat-fuse \
        libbde-dev \
        libbde-utils \
        pv
else
    info-message "Install tools - x86_64"
    sudo DEBIAN_FRONTEND=noninteractive apt -qq install -y \
        chromium \
        exfat-fuse \
        libbde-dev \
        libbde-utils \
        pv \
        torbrowser-launcher
fi

info-message "Install Google Chrome"
install-google-chrome
