#!/usr/bin/env zsh

basedir="$(cd $(dirname $0)/..; pwd)"
source "$basedir/deps.zsh"

# https://github.com/cargo-bins/cargo-binstall#linux-and-macos
url="$githubcontent/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh"
curl -L --proto '=https' --tlsv1.2 -sSf "$url" | bash

for pkg in $cargo
do
  cargo binstall $pkg
done
