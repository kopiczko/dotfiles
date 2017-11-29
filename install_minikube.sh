#!/usr/bin/env bash

if [[ "$(uname)" != "Darwin" ]]; then
    echo "ERROR currently works only on OSX" >&2
    exit 1
fi

set -ex

brew install xhyve docker-machine-driver-xhyve

sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

# Uninstall:
#rm -rf /usr/local/bin/minikube
