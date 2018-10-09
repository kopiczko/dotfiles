#!/usr/bin/env bash

set os
case $OSTYPE in
    darwin*) os="darwin" ;;
    linux*) os="linux" ;;
    *) echo "ERROR unsuported OS $OSTYPE" >&2 ; exit 1 ;;
esac

version="1.11.1"
arch="amd64"
url="https://dl.google.com/go/go${version}.${os}-${arch}.tar.gz"

if [[ -z $GOROOT ]]; then
    echo "ERROR GOROOT env var must be set" >&2
    exit 1
fi

if [[ -z $GOPATH ]]; then
    echo "ERROR GOPATH env var must be set" >&2
    exit 1
fi

if [[ -n $GOCACHE ]] && [[ ! -d $GOCACHE ]]; then
    mkdir -p $GOCACHE
fi
if [[ -n $GOTMPDIR ]] && [[ ! -d $GOTMPDIR ]]; then
    mkdir -p $GOTMPDIR
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

# Link k8s.io to github.com/kubernetes.
mkdir -p $GOPATH/src
rm -rf $GOPATH/src/k8s.io
mkdir -p $GOPATH/src/github.com/kubernetes
ln -s $GOPATH/src/github.com/kubernetes $GOPATH/src/k8s.io

# Uninstall:
#rm -rf $GOROOT/go
#rm -f $GOPATH/{bin,pkg,src}
