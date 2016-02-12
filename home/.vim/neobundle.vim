if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" A
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'fugalh/desert.vim'  " color scheme
NeoBundle 'groenewege/vim-less'
" H
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'joker1007/vim-markdown-quote-syntax'
NeoBundle 'kannokanno/previm'
NeoBundle 'mxw/vim-jsx'
" O
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'Quramy/vison' " Completion JSON files with JSON Schema
NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'rosstimson/bats.vim'  " Bats (Bash Automated Testing System)
NeoBundle 'Rykka/riv.vim'  " reStrucuturedText
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Shougo/unite.vim'
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'tyru/open-browser.vim'
" V
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'vim-scripts/Align'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'zakuro9715/httpstatus.vim'
NeoBundle 'zakuro9715/vim-b-html'

if has('nvim')
  NeoBundle 'Shougo/deoplete.nvim'
else
  NeoBundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
endif

call neobundle#end()

filetype plugin indent on
NeoBundleCheck


" =================
" Configure plugins
" =================

" Vison
" =====
autocmd BufRead,BufNewFile package.json Vison
autocmd BufRead,BufNewFile .eslintrc Vison eslintrc.json
autocmd BufRead,BufNewFile .babelrc Vison babelrc.json


" Syntastic
" =========
if exists('SyntasticStatuslineFlag')
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_cpp_compiler_options = 'std=c++14'


" Deoplete
" =========
let g:deoplete#enable_at_startup = 1


" Jedi
" ====
" don't show docstring
autocmd FileType python setlocal completeopt-=preview

let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0


" Others
" ======
let g:vim_markdown_folding_disabled=1
let g:Powerline_symbols = 'fancy'
