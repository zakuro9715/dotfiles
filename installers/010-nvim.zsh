#!/usr/bin/env zsh
#
nvim="$HOME/bin/nvim"
curl -Lo "$nvim" https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x "$nvim"
