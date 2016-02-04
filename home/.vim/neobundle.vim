﻿if has('vim_starting')
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
" ==========
NeoBundle 'Shougo/neocomplete'
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

let g:neocomplete#enable_auto_select = 0

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'


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
