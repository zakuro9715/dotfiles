call system('source "$HOME/.zsh/utils.zsh"; iswsl')
let g:iswsl = v:shell_error == 0

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

set mouse+=a
set shellslash
set iminsert=0

set wildmenu wildmode=list:longest,full
set history=10000

set visualbell t_vb=
set noerrorbells

noremap <S-Left> b
inoremap <S-Left> <C-O>b
noremap <C-Left> ^
inoremap <C-Left> <C-O>^
noremap <S-Right> w
inoremap <S-Right> <C-O>w
noremap <C-Right> $
inoremap <C-Right> <C-O>$
noremap <S-Up> <C-u>
inoremap <S-Up> <C-O><C-u>
noremap <S-Down> <C-d>
inoremap <S-Down> <C-O><C-d>
noremap <C-Up> gg
inoremap <C-Up> <C-O>gg
noremap <C-Down> G
inoremap <C-Down> <C-O>G




augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(local)
  let files = findfile('.vimrc.local', escape(a:local, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
