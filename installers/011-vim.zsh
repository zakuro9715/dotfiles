#!/usr/bin/env zsh

ghq get -p --shallow vim/vim
cd $(ghq root)/github.com/vim/vim/src

./configure --disable-gui
make
sudo make install
