#!/usr/bin/env zsh

basedir="$(cd $(dirname $0)/..; pwd)"
source "$basedir/deps.zsh"

for pkg in $cargo
do
  cargo install $pkg
done
