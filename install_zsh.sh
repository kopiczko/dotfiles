#!/bin/bash

set -e

sudo apt-get install zsh/$(lsb_release -cs)-backports

if [ ! -d $HOME/.oh-my-zsh ]; then
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  ln -s $HOME/.dotfiles/zshrc .zshrc
fi

chsh -s /bin/zsh  # in chef user resource shell attr
