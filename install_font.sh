#!/bin/bash

set -e

fonts_dir="$HOME/.local/share/fonts"

# download font file
dir="$fonts_dir/inconsolata-dz-for-powerline"
file="$dir/Inconsolata-dz for Powerline.otf"
url="https://github.com/Lokaltog/powerline-fonts/blob/master/InconsolataDz/Inconsolata-dz%20for%20Powerline.otf?raw=true"
if [ ! -d "$dir" ]; then
  mkdir -p "$dir"
fi
if [ ! -f "$file" ]; then
  curl -sSL "$url" > "$file"
fi

# update font cache
fc-cache -vf "$fonts_dir"
