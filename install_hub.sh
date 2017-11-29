#!/usr/bin/env bash

version="2.2.9"
os="darwin"
arch="amd64"
bin="hub"
url="https://github.com/github/hub/releases/download/v${version}/${bin}-${os}-${arch}-${version}.tgz"

if [[ "$(uname)" != "Darwin" ]]; then
    echo "ERROR currently works only on OSX" >&2
    exit 1
fi

set -e

rm -rf /tmp/install_${bin}
mkdir -p /tmp/install_${bin}

curl -fsSL ${url} -o /tmp/install_${bin}/${bin}.tgz
tar -xzf /tmp/install_${bin}/${bin}.tgz -C /tmp/install_${bin}/  --strip-components 1

chmod +x /tmp/install_${bin}/bin/${bin}
mv /tmp/install_${bin}/bin/${bin} /usr/local/bin/${bin}

rm -rf /tmp/install_dep

echo "Installed in /usr/locl/bin/${bin}"

# Uninstall:
#rm /usr/local/bin/hub
