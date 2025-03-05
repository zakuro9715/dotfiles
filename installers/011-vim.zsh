#!/usr/bin/env zsh

ghq get -p --shallow vim/vim
cd $(ghq root)/github.com/vim/vim/src

make clean
./configure \
  --with-features=huge \
  --prefix=/usr/local \
  --disable-gui \
  --enable-pythoninterp=yes \
  --with-python-config-dir="$(python2-config --configdir)" \
  --enable-python3interp=yes \
  --with-python3-config-dir="$(python3-config --configdir)"
make
sudo make install
