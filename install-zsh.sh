#!/bin/bash

sudo apt-get isntall zsh/$(lsb_release -cs)-backports

git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
ln -s $HOME/.dotfiles/zshrc .zshrc

chsh -s /bin/zsh  # in chef user resource shell attr
