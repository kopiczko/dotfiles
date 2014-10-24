#!/bin/bash

mkdir -p $HOME/src

# Install:
git clone https://github.com/ggreer/the_silver_searcher $HOME/src/the_silver_searcher.git -b "0.25.0" \
&& \
sudo apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev \
&& \
cd $HOME/src/the_silver_searcher.git \
&& \
./build.sh --prefix=/opt/the_silver_searcher \
&& \
sudo make install \
&& \
exit $?
