#!/usr/bin/env zsh

sudo apt update -yqq
sudo apt install -yqq libfuse2

mkdir -p "$HOME/bin"
nvim="$HOME/bin/nvim"
curl -Lo "$nvim" https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x "$nvim"
