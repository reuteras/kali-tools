#!/bin/bash
# Script to install and update capa by Fireye. More information at
# https://github.com/fireeye/capa
# From the description:
# capa detects capabilities in executable files. You run it against
# a PE file or shellcode and it tells you what it thinks the program
# can do. For example, it might suggest that the file is a backdoor,
# is capable of installing services, or relies on HTTP to communicate.

url=$(curl -s https://api.github.com/repos/fireeye/capa/releases/latest | \
    grep 'browser_download_url' | grep 'linux' | cut -d\" -f4 | head -1)
version=$(echo "$url" | grep -o -E "/v[.0-9]+/" | tr -d '/')

if [[ ! -d "$HOME"/bin ]]; then
    echo "Directory $HOME/bin doesn't exist. Create and run script again."
    exit
fi

if [[ -f "$HOME"/bin/capa && $(capa --version 2>&1 | sed -E "s/.*(v[.0-9]+).*/\1/") == "$version" ]]; then
    exit
else
    cd "$HOME"/bin || exit
    [[ -f capa ]] && rm -f capa
    wget --quiet -O capa-"$version" "$url"
    unzip capa-"$version"
    rm -f capa-"$version"
fi
