#!/bin/bash
# Install Vespasian by Praetorian, https://github.com/praetorian-inc/vespasian
# Vespasian discovers API endpoints from crawled or captured HTTP traffic
# (Burp XML, HAR, mitmproxy) and generates OpenAPI, GraphQL SDL and WSDL specs.
#
# Headless crawling uses the system Chromium (installed by setup.sh).
#
# To upgrade: change VERSION and SHA256_AMD64 (from the release checksums.txt).

set -euo pipefail

VERSION="1.0.0"
SHA256_AMD64="887ea6b328f1a33bc02cadb9aa3e1e4526d5e0df2cf057029b335957dddb8248"
BIN_DIR="$HOME/bin"

mkdir -p "$BIN_DIR"

case "$(uname -m)" in
x86_64)
    TMP_DIR=$(mktemp -d)
    trap 'rm -rf "$TMP_DIR"' EXIT
    tarball="vespasian_${VERSION}_linux_amd64.tar.gz"
    curl -fsSL -o "$TMP_DIR/$tarball" \
        "https://github.com/praetorian-inc/vespasian/releases/download/v${VERSION}/${tarball}"
    echo "$SHA256_AMD64  $TMP_DIR/$tarball" | sha256sum --check --quiet
    tar -xzf "$TMP_DIR/$tarball" -C "$TMP_DIR" vespasian
    install -m 755 "$TMP_DIR/vespasian" "$BIN_DIR/vespasian"
    ;;
aarch64)
    # No prebuilt arm64 binary upstream, build the tagged release with Go.
    command -v go > /dev/null 2>&1 || sudo apt install -y golang-go
    GOTOOLCHAIN=local GOBIN="$BIN_DIR" \
        go install "github.com/praetorian-inc/vespasian/cmd/vespasian@v${VERSION}"
    ;;
*)
    echo "Unsupported architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

command -v chromium > /dev/null 2>&1 || sudo apt install -y chromium

echo "Installed vespasian v${VERSION} in $BIN_DIR."
