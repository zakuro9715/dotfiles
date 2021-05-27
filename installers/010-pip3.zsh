#!/usr/bin/env zsh

basedir="$(cd $(dirname $0)/..; pwd)"
source "$basedir/deps.zsh"

for pkg in $pip3
do
  sudo pip3 install $pkg
done
