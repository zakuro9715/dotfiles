#!/usr/bin/env zsh

basedir="$1"
source "$basedir/deps.zsh"

for repo in $go
do
  go install "$repo"
done
