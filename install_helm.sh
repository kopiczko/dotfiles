#!/usr/bin/env bash

version="2.7.0"
download_url="https://kubernetes-helm.storage.googleapis.com/helm-v${version}-darwin-amd64.tar.gz"

if [[ "$(uname)" != "Darwin" ]]; then
    echo "ERROR currently works only on OSX" >&2
    exit 1
fi


set -ex

mkdir -p /tmp/helm
curl -Lo /tmp/helm/helm.tar.gz $download_url
tar -C /tmp/helm --strip-components 1 -zxf /tmp/helm/helm.tar.gz

chmod +x /tmp/helm/helm
sudo mv /tmp/helm/helm /usr/local/bin/
rm -rf /tmp/helm

# Uninstall:
#rm -rf /usr/local/bin/helm
