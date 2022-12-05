if &compatible
  set nocompatible
endif


if has('nvim')
  let s:plugins_root = expand('~/.cache/dein-nvim')
else
  let s:plugins_root = expand('~/.cache/dein-vim')
endif
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
call dein#add('~/src/github.com/zakuro9715/nightakashi-vim')

" Tools
call dein#add('Shougo/dein.vim')

" ================
" Markup Languages
" ================

" Markdown
call dein#add('plasticboy/vim-markdown')

" vue
call dein#add('posva/vim-vue')

" svelete
call dein#add('evanleck/vim-svelte')

" ===========
" Stylesheets
" ===========

" css
call dein#add('hail2u/vim-css3-syntax')

" =====================
" Programming Languages
" =====================

call dein#add('OmniSharp/omnisharp-vim')

" elm
call dein#add('andys8/vim-elm-syntax')
call dein#add('elm-tooling/elm-vim')

" fish
call dein#add('dag/vim-fish')

" Golang
call dein#add('mattn/vim-goimports')
let g:goimports = 1
let g:goimports_simplify = 1

" Rust
call dein#add('rust-lang/rust.vim')
let g:rustfmt_autosave = 1

" f#
call dein#add('adelarsq/neofsharp.vim')

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
"call dein#add('ollykel/v-vim')
call dein#add('~/src/github.com/zakuro9715/v-vim')
call dein#add('~/src/github.com/zakuro9715/vim-vtools')
let g:vfmt = 1
let g:vtools_use_vls = 0

" Cotowali
call dein#add('~/src/github.com/cotowali/vim-cotowali')

"pwsh
call dein#add('PProvost/vim-ps1')

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
" call dein#add('~/src/github.com/zakuro9715/vim-lsp-settings')
call dein#add('mattn/vim-lsp-settings')
call dein#add('mattn/vim-lsp-icons')


" editorconfig
call dein#add('editorconfig/editorconfig-vim')
" spell
call dein#add('kamykn/spelunker.vim')
execute 'set spellfile=' . printf('%s/%s.utf-8.add', expand('~/.vim/spell'), &spelllang)

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
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_virtual_text_prefix = "---- LSP: "
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_highlights_enabled = 1

" Others
" ======
let g:vim_markdown_folding_disabled=1
let g:Powerline_symbols = 'fancy'
