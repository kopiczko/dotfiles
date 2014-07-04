#/bin/bash

# Tested on Ubuntu 14.04.

VERSION="7-4-307"

set -e

# libx11-dev libxt-dev for clipboard support
sudo apt-get remove vim
sudo apt-get install libncurses5-dev python-dev libx11-dev libxt-dev

mkdir -p ~/src/vim
if [ -d ~/src/vim/.git ] ; then
  cd ~/src/vim && git pull origin master --tags
else
  git clone git@github.com:b4winckler/vim.git ~/src/vim
fi
cd ~/src/vim && git clean -Xdf && git checkout v$VERSION && make distclean && \
  ./configure --prefix="/opt/vim-$VERSION" \
     --enable-pythoninterp \
     --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
     --enable-multibyte \
     --with-x \
     --with-features=huge \
     --enable-fail-if-missing && make && sudo make install 
if [ -h /opt/vim ] ; then
  sudo rm /opt/vim
fi
sudo ln -s vim-$VERSION /opt/vim
