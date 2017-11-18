#!/usr/bin/env bash

version="1.9.2"
os="darwin"
arch="amd64"
url="https://redirector.gvt1.com/edgedl/go/go${version}.${os}-${arch}.tar.gz"

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

set -ex

mkdir -p /tmp/install_go
mkdir -p /tmp/install_go/go

curl -fsSL ${url} -o /tmp/install_go/go.tar.gz
tar -C /tmp/install_go/go --strip-components 1 -zxf /tmp/install_go/go.tar.gz

mkdir -p $(dirname $GOROOT)
rm -rf $GOROOT
mv /tmp/install_go/go $GOROOT

rm -rf /tmp/install_go

mkdir -p $GOPATH/src
rm -f $GOPATH/src/k8s.io
ln -s $GOPATH/src/github.com/kubernetes $GOPATH/src/k8s.io

# Uninstall:
#rm -rf $GOROOT/go
#rm -f $GOPATH/src/k8s.io
