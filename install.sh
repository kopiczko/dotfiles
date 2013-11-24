#!/bin/bash

scriptdir=`cd "$(dirname $0)" ; pwd`

#s_dry_run="t"

function dry_run {
    if [ "x$s_dry_run" == "xt" ] ; then
	return 0
    fi
    return 1
}

function create_link {
    source="$HOME/.$1"
    if [ -z $2 ] ; then
	target="$scriptdir/$1"
    else
	target="$scriptdir/$2"
    fi
    # Check if source directory exists, create if not
    source_dir=`dirname $source`
    if [ ! -d $source_dir ] ; then
	if dry_run ; then
	    echo "Would create directory $source_dir"
	else
	    mkdir -p $source_dir
	fi
    fi
    # Create link
    if [ ! -h $source ] ; then
	if dry_run ; then
       	    echo "Would create link: $source -> $target"
	else
	    ln -s $target $source
	fi
    fi
}

function append_line {
    file="$HOME/$1"
    line="$2"
    if ! grep -Fxq "$line" $file ; then
	if dry_run ; then
	    echo "Would add line '$line' to file $file"
	else
	    echo "$line" >> $file
	fi
    fi
}

create_link "rbenv" "rbenv.git"
create_link "rbenv/plugins/ruby-build" "ruby-build.git"

create_link "local/bin/env.sh"
append_line ".bashrc" "source ~/.local/bin/env.sh"
