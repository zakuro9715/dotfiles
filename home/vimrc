filetype off
syntax on


color desert

set t_Co=256

set nocompatible
set background=dark
set fileformat=unix

set number
set nocursorline
set nocursorcolumn
set laststatus=2
set cmdheight=3
set showmatch
set helpheight=999
set nolist

set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set scrolloff=8
set sidescrolloff=16
set sidescroll=1

set confirm
set hidden
set autoread
set nobackup
set noswapfile

set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set gdefault

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

set clipboard=unnamed,unnamedplus
set mouse=a
set shellslash
set iminsert=0

set wildmenu wildmode=list:longest,full
set history=10000

set visualbell t_vb=
set noerrorbells


" Load settings for each location.
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

source $HOME/.vim/neobundle.vim
source $HOME/.vim/fmt.vim

filetype indent plugin on
