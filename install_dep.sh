#!/usr/bin/env bash

set os
case $OSTYPE in
    darwin*) os="darwin" ;;
    linux*) os="linux" ;;
    *) echo "ERROR unsuported OS $OSTYPE" >&2 ; exit 1 ;;
esac

version="v0.5.0"
arch="amd64"

url="https://github.com/golang/dep/releases/download/${version}/dep-${os}-${arch}"

if [[ "$(uname)" != "Darwin" ]]; then
    echo "ERROR currently works only on OSX" >&2
    exit 1
fi

if [[ -z $GOROOT ]]; then
    echo "ERROR GOROOT env var must be set" >&2
    exit 1
fi

if [[ -z $GOPATH ]]; then
    echo "ERROR GOPATH env var must be set" >&2
    exit 1
fi

set -e

rm -rf /tmp/install_dep
mkdir -p /tmp/install_dep

curl -fsSL ${url} -o /tmp/install_dep/dep

chmod +x /tmp/install_dep/dep
mv /tmp/install_dep/dep /usr/local/bin/dep

rm -rf /tmp/install_dep

echo "Installed in /usr/locl/bin/dep"

# Uninstall:
#rm -f /usr/local/bin/dep
