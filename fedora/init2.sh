#!/usr/bin/env bash

set -e
set -o pipefail

set -x

mkdir -p ~/Code/github.com/kopiczko
pushd ~/Code/github.com/kopiczko
git clone git@github.com:kopiczko/dotfiles.git
popd
