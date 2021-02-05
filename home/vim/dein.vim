if &compatible
  set nocompatible
endif

let s:plugins_root = expand('~/.cache/dein')
let s:dein_root = s:plugins_root . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_root)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_root
endif
execute 'set runtimepath^=' . s:dein_root


call dein#begin(s:plugins_root)

" ========
" Vim Core
" ========

" Color scheme
call dein#add('ghifarit53/tokyonight-vim')

" Tools
call dein#add('Shougo/dein.vim')

" ================
" Markup Languages
" ================

" Markdown
call dein#add('plasticboy/vim-markdown')
call dein#add('kannokanno/previm')  " Markdown Preview

" reStrucuturedText
call dein#add('Rykka/riv.vim')

" vue
call dein#add('posva/vim-vue')

" ===========
" Stylesheets
" ===========

" css
call dein#add('hail2u/vim-css3-syntax')

" stylus
call dein#add('wavded/vim-stylus')

" =====================
" Programming Languages
" =====================

" bash
call dein#add('rosstimson/bats.vim')  " Bats (Bash Automated Testing System)

" elm
call dein#add('andys8/vim-elm-syntax')
call dein#add('elm-tooling/elm-vim')

" fish
call dein#add('dag/vim-fish')

" Golang
call dein#add('mattn/vim-goimports')
let g:goimports = 1
let g:goimports_simplify = 1

" javascript
call dein#add('mxw/vim-jsx')
call dein#add('pangloss/vim-javascript')

" Ruby
call dein#add('vim-ruby/vim-ruby')

" typescript
call dein#add('leafgarland/typescript-vim')
call dein#add('clausreinke/typescript-tools.vim', { 'build': 'npm install'  })

" vlang
"call dein#add('cheap-glitch/vim-v')
call dein#add('ollykel/v-vim')
call dein#add('~/src/github.com/zakuro9715/vim-vtools')
let g:vfmt = 1

" ===============
" Other Languages
" ===============

" JSON
call dein#add('google/vim-jsonnet')
call dein#add('Quramy/vison') " Completion JSON files with JSON Schema

" =====
" Tools
" =====

" lsp / completion
call dein#add('prabirshrestha/async.vim')
call dein#add('prabirshrestha/asyncomplete.vim')
call dein#add('prabirshrestha/asyncomplete-lsp.vim')
call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')
call dein#add('mattn/vim-lsp-icons')


" editorconfig
call dein#add('editorconfig/editorconfig-vim')

" others
call dein#add('zakuro9715/httpstatus.vim')
call dein#add('preservim/nerdcommenter')
call dein#add('tpope/vim-commentary')
call dein#add('thinca/vim-quickrun')

call dein#end()

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

" =================
" Configure plugins
" =================

" Color scheme
" ============
set termguicolors

let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 1

colorscheme tokyonight

" Vison
" =====
autocmd BufRead,BufNewFile package.json Vison
autocmd BufRead,BufNewFile .eslintrc Vison eslintrc.json
autocmd BufRead,BufNewFile .babelrc Vison babelrc.json


" Deoplete
" =========
let g:deoplete#enable_at_startup = 1


" Riv
" ===
let g:riv_disable_folding = 1

" LSP / Complete
" ==============
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_highlights_enabled = 1

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" Others
" ======
let g:vim_markdown_folding_disabled=1
let g:Powerline_symbols = 'fancy'
