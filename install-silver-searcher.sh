#!/bin/bash

mkdir -p $HOME/src

# Install:
git clone https://github.com/ggreer/the_silver_searcher $HOME/src/the_silver_searcher.git -b "0.18.1" \
&& \
sudo apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev \
&& \
cd $HOME/src/the_silver_searcher.git \
&& \
./build.sh --prefix=/opt/the_silver_searcher \
&& \
sudo make install \
&& \
sudo stow -v -d /opt -t /usr/local -S the_silver_searcher \
&& \
exit $?

## Uninstall:
#sudo stow -v -d /opt -t /usr/local -D the_silver_searcher \
#&& \
#sudo rm -rf /opt/the_silver_searcher \
#&& \
#rm -rf $HOME/src/the_silver_searcher.git \
#&& \
#exit $?



