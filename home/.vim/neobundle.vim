if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'



" =======
"   Vim
" =======


" Appearance
" ==========

" Color
" -----
NeoBundle 'fugalh/desert.vim'

" Powerline
" ---------
NeoBundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
let g:Powerline_symbols = 'fancy'

" Completion
" ===========

" deoplete
" --------
if has('nvim')
  NeoBundle 'Shougo/deoplete.nvim'
endif


" Syntax check
" ============
NeoBundle 'scrooloose/syntastic'
set statusline+=%#warningmsg#
if exists('SyntasticStatuslineFlag')
  set statusline+=%{SyntasticStatuslineFlag()}
endif
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_cpp_compiler_options = 'std=c++14'


" Web tool
" ========
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'zakuro9715/httpstatus.vim'


" Other
" =====
NeoBundle 'Shougo/unite.vim'



" ====================
"   Language Support
" ====================


" Text
" ====

" Markdown
" --------
NeoBundle 'joker1007/vim-markdown-quote-syntax'
NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'kannokanno/previm'
let g:vim_markdown_folding_disabled=1

" reStructuredText
" ----------------
NeoBundle 'Rykka/riv.vim'

" CSV
" ---
NeoBundle 'chrisbra/csv.vim'


" Shell
" =====

" Bats
" ----
NeoBundle 'vim-scripts/bats.vim'


" JSON
" ====

NeoBundle 'Quramy/vison'
autocmd BufRead,BufNewFile package.json Vison


" HTML
" ====

" Slim
" ----
NeoBundle 'slim-template/vim-slim'

" Jade
" ----
NeoBundle 'digitaltoad/vim-jade'

" b-html
" ------
NeoBundle 'zakuro9715/vim-b-html'


" ECMAScript
" ==========
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'


" CSS
" ===

" CSS3
" ----
NeoBundle 'hail2u/vim-css3-syntax'

" LESS
" ----
NeoBundle 'groenewege/vim-less'

" Stylus
" ------
NeoBundle 'wavded/vim-stylus'

" Other
" =====

" Go
" --
NeoBundle 'vim-jp/vim-go-extra'

" Python
" ------
NeoBundle 'davidhalter/jedi-vim'
" don't show docstring
autocmd FileType python setlocal completeopt-=preview

let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0


call neobundle#end()

filetype plugin indent on
NeoBundleCheck
