﻿filetype off
syntax on

source $HOME/.vim/core.vim
if g:iswsl
  source $HOME/.vim/wsl.vim
endif
source $HOME/.vim/dein.vim
source $HOME/.vim/fmt.vim
source $HOME/.vim/commands.vim

filetype indent plugin on
