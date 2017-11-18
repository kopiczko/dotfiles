#!/usr/bin/env bash

version="v0.3.2"
os="darwin"
arch="amd64"
url="https://github.com/golang/dep/releases/download/${version}/dep-${os}-${arch}"
sha256="39410a604a6cdb16206dec4cf3eb6e30cd653321c68c7325a939321ad0cdc91a"

check_sha256() {
    local sum=$1; shift
    local path=$1; shift
    local got="$(openssl dgst -sha256 $path | cut -d ' ' -f 2)"
    if [[ "${got}" != "${sum}" ]]; then
        echo "ERROR bad checksum" >&2
        echo "        got:  ${got}" >&2
        echo "        want: ${sum}" >&2
        exit 1
    fi
}

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
check_sha256 ${sha256} /tmp/install_dep/dep 

chmod +x /tmp/install_dep/dep
mv /tmp/install_dep/dep /usr/local/bin/dep

rm -rf /tmp/install_dep

echo "Installed in /usr/locl/bin/dep"

# Uninstall:
#rm -f /usr/local/bin/dep
