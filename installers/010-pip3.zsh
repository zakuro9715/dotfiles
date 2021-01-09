#!/usr/bin/env zsh

basedir="$1"
source "$basedir/deps.zsh"

for pkg in $pip3
do
  sudo pip3 install $pkg
done
