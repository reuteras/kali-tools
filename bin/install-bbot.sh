#!/bin/bash

cd ~/src || exit

[[ -d bbot-vivagraphjs ]] || git clone https://github.com/blacklanternsecurity/bbot-vivagraphjs.git

which pipx > /dev/null 2>&1 || sudo apt install pipx

[[ -d ~/bin ]] || mkdir ~/bin 
[[ -f ~/bin/websocat ]] || curl -s -o ~/bin/websocat https://github.com/vi/websocat/releases/download/v1.13.0/websocat.aarch64-unknown-linux-musl && chmod +x ~/bin/websocat

pipx install bbot
