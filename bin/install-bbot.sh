#!/bin/bash
# Install bbot, https://github.com/blacklanternsecurity/bbot

set -euo pipefail

command -v pipx > /dev/null 2>&1 || sudo apt install -y pipx

pipx install bbot
pipx ensurepath
