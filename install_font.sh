#!/bin/bash

set -e

fonts_dir="$HOME/.fonts"

# download font file
dir="$fonts_dir/inconsolata-dz-for-powerline"
file="$dir/Inconsolata-dz for Powerline.otf"
url="https://github.com/Lokaltog/powerline-fonts/blob/master/InconsolataDz/Inconsolata-dz%20for%20Powerline.otf?raw=true"
if [ ! -d $dir  ]; then
  mkdir -p $dir
  if [ ! -f $file ]; then
    curl $url > $file
  fi
fi

# update font cache
fc-cache -vf $fonts_dir
