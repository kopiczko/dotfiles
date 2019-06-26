#!/usr/bin/env bash

version="2.12.2"
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

# -----------------------------------------------------------------------------
# Install registry plugin

mkdir -p ~/.helm/plugins/

if [[ -d ~/.helm/plugins/registry/.git ]]; then
    cd ~/.helm/plugins/registry && git pull origin master
    helm registry upgrade-plugin
else
    cd ~/.helm/plugins/ && git clone https://github.com/app-registry/appr-helm-plugin.git registry
fi

# -----------------------------------------------------------------------------
# Uninstall:
#rm -rf /usr/local/bin/helm
