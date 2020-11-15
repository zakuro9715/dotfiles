#!/usr/bin/env zsh

basedir="$1"
source "$basedir/deps.zsh"

for repo in $ppa
do
  sudo add-apt-repository -y $repo
done

sudo apt -yqq update

sudo apt install -yqq $apt
