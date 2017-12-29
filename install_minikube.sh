#!/usr/bin/env bash

if [[ "$(uname)" != "Darwin" ]]; then
    echo "ERROR currently works only on OSX" >&2
    exit 1
fi

set -ex

rm -rf /tmp/install_minikube
mkdir -p /tmp/install_minikube

curl -Lo /tmp/install_minikube/minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
chmod +x minikube
sudo mv /tmp/install_minikube/minikube /usr/local/bin/

rm -rf /tmp/install_minikube

# Uninstall:
#rm -rf /usr/local/bin/minikube
