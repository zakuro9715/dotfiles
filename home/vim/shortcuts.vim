:command! Error LspNextError
noremap e <Plug>(lsp-next-error)
inoremap <C-d> <C-O><Plug>(lsp-next-error)
:command! Warn LspNextWarning
:command! Diag LspNextDiagnostic
:command! Hover LspHover
:command! -range=% Fmt call s:lsp_format(<range>, <line1>, <line2>)
noremap <tab> :LspHover<CR>

function! s:lsp_format(range, line1, line2)
  if a:range
    let l:servers = filter(lsp#get_allowed_servers(), 'lsp#capabilities#has_document_range_formatting_provider(v:val)')
    if !empty(l:servers)
      execute a:line1 . ',' . a:line2 . 'LspDocumentRangeFormat'
      return
    endif
  endif

  LspDocumentFormat
endfunction

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

function! s:npm_lint()
  call system('npm run lint -- ' . expand('%'))
  execute ':e'
endfunction
:command! NpmLint call s:npm_lint()

:command! Reload :source ~/.vimrc
:command! T Test

" Move by:
"     I
"    JKL
" In dvorak
"     C
"    HTN


" left: qwerty: j, dvorac h
nnoremap h <Left>
inoremap <ESC>j <Left>
noremap <S-Left> b
inoremap <S-Left> <C-O>b
noremap <S-h> b
inoremap <ESC><S-j> <C-O>b
noremap <C-Left> ^
inoremap <C-Left> <C-O>^
noremap <C-j> ^
inoremap <ESC><C-j> <C-O>^

" right: qwerty: l, dvorac n
nnoremap n <Right>
inoremap <ESC>l <Right>
noremap <S-Right> w
inoremap <S-Right> <C-O>w
noremap <S-l> w
inoremap <ESC><S-n> <C-O>w
noremap <C-Right> $
inoremap <C-Right> <C-O>$
noremap <C-n> ^
inoremap <ESC><C-n> <C-O>^

" up: qwerty: i, dvorac c
nnoremap <Up> g<Up>
nnoremap c g<Up>
inoremap <Up> <C-O>g<Up>
noremap <S-Up> <C-u>
inoremap <S-Up> <C-O><C-u>
noremap <S-c> <C-u>
inoremap <ESC><S-i> <C-O><C-u>
noremap <C-Up> gg
inoremap <C-Up> <C-O>gg

" down: qwerty: k, dvorac t
nnoremap <Down> g<Down>
nnoremap t g<Down>
inoremap <Down> <C-O>g<Down>
noremap <S-Down> <C-d>
inoremap <S-Down> <C-O><C-d>
noremap <S-t> <C-d>
inoremap <ESC><S-k> <C-O><C-d>
noremap <C-Down> G
inoremap <C-Down> <C-O>G

" dvorak: k
" qwerty: v
nnoremap k v

" save by ctrl-s
inoremap <C-s> <C-O>:w<CR>
noremap <C-s> :w<CR>
" exit by ctrl-x
inoremap <C-x> <C-O>:q<CR>
noremap <C-x> :q<CR>

" visual-block by ctrl-q
noremap <C-q> <C-v>
