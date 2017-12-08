#!/bin/env bash

if [[ "$(uname)" != "Darwin" ]]; then
    echo "ERROR currently works only on OSX" >&2
    exit 1
fi

brew uninstall gnu-sed

set -e

brew install gnu-sed --with-default-names
