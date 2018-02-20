#!/usr/bin/env bash

set os
case $OSTYPE in
    darwin*) os="darwin" ;;
    linux*) os="linux" ;;
    *) echo "ERROR unsuported OS $OSTYPE" >&2 ; exit 1 ;;
esac

version=$(curl -is "https://github.com/wercker/stern/releases/latest" | grep "Location:")
version=$(echo ${version} | cut -d ' ' -f 2 | tr -d '[:space:]')
version=$(basename ${version})


rm -rf /tmp/install_stern
mkdir -p /tmp/install_stern

set -ex

url="https://github.com/wercker/stern/releases/download/${version}/stern_${os}_amd64"

curl -Lo /tmp/install_stern/stern "$url"
chmod +x /tmp/install_stern/stern
sudo mv /tmp/install_stern/stern /usr/local/bin/

rm -rf /tmp/install_stern

# Uninstall:
#rm -rf /usr/local/bin/stern
