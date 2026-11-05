#!/bin/bash

set -euo pipefail

function info-message() {
    echo "**** INFO: $*"
}

function apt-noninteractive() {
    sudo DEBIAN_FRONTEND=noninteractive APT_LISTCHANGES_FRONTEND=none apt \
        -o Dpkg::Options::=--force-confold \
        -o Dpkg::Options::=--force-confdef \
        "$@"
}

# Install Google Chrome (only available for x86_64)
function install-google-chrome() {
    if dpkg --status google-chrome-stable > /dev/null 2>&1; then
        return
    fi
    info-message "Installing Google Chrome."
    local tmp_dir
    tmp_dir=$(mktemp -d)
    curl -fsSL -o "$tmp_dir/google-chrome-stable_current_amd64.deb" \
        https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt-noninteractive -qq install -y "$tmp_dir/google-chrome-stable_current_amd64.deb"
    rm -rf "$tmp_dir"
}

PACKAGES=(
    chromium
    exfat-fuse
    libbde-dev
    libbde-utils
    pv
)

info-message "Running apt update."
sudo apt -qq update
info-message "Running apt dist-upgrade."
apt-noninteractive -y dist-upgrade

ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
    PACKAGES+=(torbrowser-launcher)
fi

info-message "Install tools - $ARCH"
apt-noninteractive -qq install -y "${PACKAGES[@]}"

if [[ "$ARCH" == "x86_64" ]]; then
    install-google-chrome
fi
