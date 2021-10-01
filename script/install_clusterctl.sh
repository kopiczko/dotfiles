#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

function main() {
    local tmp_dir="$1" ; shift
    local bin="clusterctl"

    case $OSTYPE in
        darwin*) local os="darwin" ;;
        linux*) local os="linux" ;;
        *) echo "ERROR unsuported OS $OSTYPE" >&2 ; exit 1 ;;
    esac

    local version="0.3.14"
    local arch="amd64"
    local url="https://github.com/kubernetes-sigs/cluster-api/releases/download/v${version}/clusterctl-${os}-${arch}"

    curl -fsSL ${url} -o ${tmp_dir}/${bin}
    chmod +x ${tmp_dir}/${bin}
    mv ${tmp_dir}/${bin} $HOME/.local/bin
}

mkdir -p /tmp/install_clusterctl
main /tmp/install_clusterctl
rm -rf /tmp/install_clusterctl
