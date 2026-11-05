#!/bin/bash
# Script to install and update capa by Mandiant. More information at
# https://github.com/mandiant/capa
# From the description:
# capa detects capabilities in executable files. You run it against
# a PE file or shellcode and it tells you what it thinks the program
# can do. For example, it might suggest that the file is a backdoor,
# is capable of installing services, or relies on HTTP to communicate.

set -euo pipefail

BIN_DIR="$HOME/bin"

if [[ ! -d "$BIN_DIR" ]]; then
    echo "Directory $BIN_DIR doesn't exist. Create it and run the script again." >&2
    exit 1
fi

case "$(uname -m)" in
    x86_64) asset_suffix="linux.zip" ;;
    aarch64) asset_suffix="linux-arm64.zip" ;;
    *)
        echo "Unsupported architecture: $(uname -m)" >&2
        exit 1
        ;;
esac

url=$(curl -fsSL https://api.github.com/repos/mandiant/capa/releases/latest |
    grep '"browser_download_url"' | cut -d\" -f4 | grep -E -- "-${asset_suffix}\$" | head -1)
if [[ -z "$url" ]]; then
    echo "Could not find a capa release asset ending in -${asset_suffix}." >&2
    exit 1
fi
version=$(echo "$url" | grep -o -E "/v[.0-9]+/" | tr -d '/')

if [[ -x "$BIN_DIR/capa" ]]; then
    installed=$("$BIN_DIR/capa" --version 2>&1 | sed -E "s/.*(v[.0-9]+).*/\1/")
    if [[ "$installed" == "$version" ]]; then
        exit 0
    fi
fi

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

curl -fsSL -o "$TMP_DIR/capa.zip" "$url"
unzip -q -o "$TMP_DIR/capa.zip" -d "$TMP_DIR"
install -m 755 "$TMP_DIR/capa" "$BIN_DIR/capa"
echo "Installed capa $version in $BIN_DIR."
