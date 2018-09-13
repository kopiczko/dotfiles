#!/usr/bin/env bash

version="0.11.1"
os="darwin"
arch="amd64"
bin="vault"
url="https://releases.hashicorp.com/vault/${version}/vault_${version}_${os}_${arch}.zip"

if [[ "$(uname)" != "Darwin" ]]; then
    echo "ERROR currently works only on OSX" >&2
    exit 1
fi

set -e

rm -rf /tmp/install_${bin}
mkdir -p /tmp/install_${bin}

curl -fsSL ${url} -o /tmp/install_${bin}/${bin}.zip
cd /tmp/install_${bin} && unzip /tmp/install_${bin}/${bin}.zip >/dev/null

chmod +x /tmp/install_${bin}/${bin}
mv /tmp/install_${bin}/${bin} /usr/local/bin/${bin}

rm -rf /tmp/install_${bin}

echo "Installed in /usr/locl/bin/${bin}"

# Uninstall:
#rm /usr/local/bin/vault
