#!/usr/bin/env bash -e

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mk_link() {
    if [[ $# -ne 2 ]]; then
        echo "usage: mk_link SRC DST" >&2
        exit 1
    fi

    local s=$1; shift
    local t=$1; shift

    if [[ -h $t ]] && [[ "$(readlink $t)" == "$s" ]]; then
        echo "I $t exists and links to $s"
        return 0
    fi
    if [[ -h $t ]]; then
        echo "E $t exists but links to $(readlink $t), needs to be FIXED manually"
        return 1
    fi
    if [[ -e $t ]]; then
        echo "E $t exists but it is not a link, needs to be FIXED manually"
        return 1
    fi
    echo "I $t creating a link to $s"
    ln -s $s $t
}

mkdir -p $HOME/.config

for f in $(ls ${dir}/config); do
    s="$dir/config/$f"
    t="$HOME/.config/$f"

    mk_link $s $t
done

files="$files aliases"
files="$files aliases.d"
files="$files envs"
files="$files git_template"
files="$files gitconfig"
files="$files gitignore_global"
files="$files tmux.conf"
files="$files zshrc"

for f in $files; do
    s="$dir/$f"
    t="$HOME/.$f"

    mk_link $s $t
done
