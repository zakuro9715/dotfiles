#!/usr/bin/env zsh

basedir="$(cd $(dirname $0)/..; pwd)"
source "$basedir/deps.zsh"

for pkg in $npm
do
  sudo npm -g install $pkg
  sudo npm -g update $pkg
done

