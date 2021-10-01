#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

function main() {
    local version="$1" ; shift

    local bin="kubebuilder"

    local arch os
    arch="$(go env GOARCH)"
    os="$(go env GOOS)"

    local tmp_dir="/tmp/install_${bin}"
    mkdir -p ${tmp_dir}

    local url="https://github.com/kubernetes-sigs/kubebuilder/releases/download/v${version}/kubebuilder_${version}_${os}_${arch}.tar.gz"

    curl -fsSL ${url} | tar -C ${tmp_dir} --strip-components 1 -zx
    #mv ${tmp_dir}/bin/kubebuilder $HOME/.local/bin

    #rm -rf ${tmp_dir}
}

# https://github.com/kubernetes-sigs/kubebuilder/releases
main "2.3.2"
