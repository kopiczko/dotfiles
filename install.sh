#!/usr/bin/env bash

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

set -e

mkdir -p $HOME/.config

for f in $(ls ${dir}/config); do
    s="$dir/config/$f"
    t="$HOME/.config/$f"
    if [[ -h $t ]] && [[ "$(readlink $t)" == "$s" ]]; then
        echo "I $t exists and links to $s"
        continue
    fi
    if [[ -h $t ]]; then
        echo "E $t exists but links to $(readlink $t), needs to be FIXED manually"
        continue
    fi
    if [[ -e $t ]]; then
        echo "E $t exists but it is not a link, needs to be FIXED manually"
        continue
    fi
    echo "I $t creating a link to $s"
    ln -s $s $t
done
