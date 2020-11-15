#!/bin/sh

if ! which zsh > /dev/null
then
  sudo apt install -yqq zsh
fi

if ! which git > /dev/null
then
  sudo apt install -yqq git
fi

zakuro="$HOME/src/github.com/zakuro9715"
mkdir -p "$zakuro" && cd "$zakuro" || exit 1
if ! [ -d "$zakuro/dotfiles" ]
then
  git clone git@github.com:zakuro9715/dotfiles
fi
cd "$zakuro/dotfiles" || exit 1
zsh bootstrap.zsh
