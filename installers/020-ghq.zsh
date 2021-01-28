#!/usr/bin/env zsh

basedir="$1"
source "$basedir/deps.zsh"
for v in $ghq
do
  ghq get $v
done
