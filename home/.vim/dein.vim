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
  call dein#add('fugalh/desert.vim')
  call dein#add('tomasr/molokai')
  call dein#add('altercation/vim-colors-solarized')

" Tools
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/unite.vim')

" ================
" Markup Languages
" ================

" b-html
  call dein#add('zakuro9715/vim-b-html')

" Jade
  call dein#add('digitaltoad/vim-jade')

" Markdown
  call dein#add('joker1007/vim-markdown-quote-syntax')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('kannokanno/previm')  " Markdown Preview

" reStrucuturedText
  call dein#add('Rykka/riv.vim')

" slim
  call dein#add('slim-template/vim-slim')

" vue
  call dein#add('posva/vim-vue')

" ===========
" Stylesheets
" ===========

" css
  call dein#add('hail2u/vim-css3-syntax')

" Less
  call dein#add('groenewege/vim-less')

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

" Go
  call dein#add('vim-jp/vim-go-extra')

" javascript
  call dein#add('mxw/vim-jsx')
  call dein#add('pangloss/vim-javascript')

" python
  call dein#add('davidhalter/jedi-vim')

" Ruby
  call dein#add('vim-ruby/vim-ruby')

" typescript
  call dein#add('leafgarland/typescript-vim')
  call dein#add('clausreinke/typescript-tools.vim', { 'build': 'npm install'  })

" ===============
" Other Languages
" ===============

" JSON
  call dein#add('google/vim-jsonnet')
  call dein#add('Quramy/vison') " Completion JSON files with JSON Schema

" ANTLR
  call dein#add('jrozner/vim-antlr')

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

" ======
" Others
" ======

  call dein#add('tyru/open-browser.vim')
  call dein#add('scrooloose/syntastic')
  call dein#add('zakuro9715/httpstatus.vim')
  call dein#add('vim-scripts/Align')

if has('nvim')
  call dein#add('Shougo/deoplete.nvim')
endif

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
let g:solarized_termcolors=256

colorscheme desert

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


" Riv
" ===
let g:riv_disable_folding = 1

" LSP
" ===
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_highlights_enabled = 1

" Others
" ======
let g:vim_markdown_folding_disabled=1
let g:Powerline_symbols = 'fancy'
