#!/bin/bash
# Install masstin, https://github.com/jupyterj0nes/masstin
# masstin parses Windows, Linux and macOS evidence (EVTX, journald, unified
# logs, disk images, triage zips) into a lateral movement timeline and graph.
#
# Upstream publishes no checksums, the hash below was computed from the
# v1.4.0 release binary. Note that crates.io is outdated (0.14.0), so
# don't use "cargo install masstin".
#
# To upgrade: change VERSION and SHA256_LINUX (sha256sum of the new binary).

set -euo pipefail

VERSION="1.4.0"
SHA256_LINUX="137af8e5c2012ac667555529b78e096959c13dc7bedcfbc02d1c78b913ce8485"
BIN_DIR="$HOME/bin"

mkdir -p "$BIN_DIR"

case "$(uname -m)" in
x86_64)
    TMP_DIR=$(mktemp -d)
    trap 'rm -rf "$TMP_DIR"' EXIT
    curl -fsSL -o "$TMP_DIR/masstin" \
        "https://github.com/jupyterj0nes/masstin/releases/download/v${VERSION}/masstin-v${VERSION}-linux"
    echo "$SHA256_LINUX  $TMP_DIR/masstin" | sha256sum --check --quiet
    install -m 755 "$TMP_DIR/masstin" "$BIN_DIR/masstin"
    ;;
aarch64)
    # No prebuilt arm64 binary upstream, build the tagged release with Cargo.
    sudo apt install -y build-essential cargo pkg-config
    cargo install --locked --root "$HOME/.local" \
        --git https://github.com/jupyterj0nes/masstin --tag "v${VERSION}"
    ln -sf "$HOME/.local/bin/masstin" "$BIN_DIR/masstin"
    ;;
*)
    echo "Unsupported architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

echo "Installed masstin v${VERSION} in $BIN_DIR."
