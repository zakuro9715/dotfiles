#!/usr/bin/env zsh

basedir="$(cd $(dirname $0)/..; pwd)"
source "$basedir/deps.zsh"

for repo in $go
do
  go install "$repo"
done

for repo in $go_get
do
  go get -u "$repo"
done
