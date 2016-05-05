if &compatible
  set nocompatible
endif

let s:plugins_root = expand('~/.cache/dein')
let s:dein_root = s:plugins_root . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_root)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_root
endif
execute 'set runtimepath^=' . s:dein_root


" ===================
" Add plugins to dein
" ===================

call dein#begin(s:plugins_root)

call dein#add('Shougo/dein.vim')

" A
call dein#add('davidhalter/jedi-vim')
call dein#add('digitaltoad/vim-jade')
call dein#add('fugalh/desert.vim')  " color scheme
call dein#add('groenewege/vim-less')
" H
call dein#add('hail2u/vim-css3-syntax')
call dein#add('joker1007/vim-markdown-quote-syntax')
call dein#add('kannokanno/previm')  " Markdown Preview
call dein#add('mxw/vim-jsx')
" O
call dein#add('pangloss/vim-javascript')
call dein#add('Quramy/vison') " Completion JSON files with JSON Schema
call dein#add('rcmdnk/vim-markdown')
call dein#add('rosstimson/bats.vim')  " Bats (Bash Automated Testing System)
call dein#add('Rykka/riv.vim')  " reStrucuturedText
call dein#add('scrooloose/syntastic')
call dein#add('Shougo/unite.vim')
call dein#add('slim-template/vim-slim')
call dein#add('tyru/open-browser.vim')
" V
call dein#add('vim-jp/vim-go-extra')
call dein#add('vim-ruby/vim-ruby')
call dein#add('vim-scripts/Align')
call dein#add('wavded/vim-stylus')
call dein#add('zakuro9715/httpstatus.vim')
call dein#add('zakuro9715/vim-b-html')

if has('nvim')
  call dein#add('Shougo/deoplete.nvim')
else
  call dein#add('powerline/powerline', {'rtp': 'powerline/bindings/vim/'})
endif

call dein#end()

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

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
