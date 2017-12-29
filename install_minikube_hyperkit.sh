#!/usr/bin/env bash
version="latest"
#os="darwin"
#arch="amd64"
bin="docker-machine-driver-hyperkit"
url="https://storage.googleapis.com/minikube/releases/${version}/docker-machine-driver-hyperkit"

if [[ "$(uname)" != "Darwin" ]]; then
    echo "ERROR currently works only on OSX" >&2
    exit 1
fi

set -ex

rm -rf /tmp/install_${bin}
mkdir -p /tmp/install_${bin}

mkdir /tmp/install_${bin}/bin
curl -fSL ${url} -o /tmp/install_${bin}/bin/${bin}

chmod +x /tmp/install_${bin}/bin/${bin}
sudo chown root:wheel /tmp/install_${bin}/bin/${bin}
sudo chmod u+s /tmp/install_${bin}/bin/${bin}
mv /tmp/install_${bin}/bin/${bin} /usr/local/bin/${bin}

rm -rf /tmp/install_${bin}

echo "Installed in /usr/local/bin/${bin}"

# Uninstall:
#rm /usr/local/bin/docker-machine-driver-hyperkit
