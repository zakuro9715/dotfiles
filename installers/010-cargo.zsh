#!/usr/bin/env zsh

basedir="$1"
source "$basedir/deps.zsh"

for pkg in $cargo
do
  cargo install $pkg
done
