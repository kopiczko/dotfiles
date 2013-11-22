#!/bin/bash

scriptdir=`cd "$(dirname $0)" ; pwd`

function create_link {
    source="$HOME/.$1"
    target="$scriptdir/$1"
    if [[ -f $source ]] ; then
	echo "Link $source already exists"
    else
	ln -s $target $source
    fi
}

function append_line {
    file="$HOME/$1"
    line="$2"
    if grep -Fxq "$line" $file ; then
	echo "Line '$line' already added to file $file"
    else
	echo "$line" >> $file
    fi
}

create_link "local/bin/env.sh"
append_line ".bashrc" "source ~/.local/bin/env.sh"
