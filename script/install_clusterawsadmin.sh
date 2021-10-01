#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

function main() {
    local version="$1" ; shift

    local arch="amd64"
    local bin="clusterawsadm"

    local tmp_dir="/tmp/install_${bin}"

    mkdir -p ${tmp_dir}

    case $OSTYPE in
        darwin*) local os="darwin" ;;
        linux*) local os="linux" ;;
        *) echo "ERROR unsuported OS $OSTYPE" >&2 ; exit 1 ;;
    esac

    local url="https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/v${version}/clusterawsadm-${os}-${arch}"

    curl -fsSL ${url} -o ${tmp_dir}/${bin}
    chmod +x ${tmp_dir}/${bin}
    mv ${tmp_dir}/${bin} $HOME/.local/bin

    rm -rf ${tmp_dir}
}

# https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases
main "0.6.4"
