" Move by:
"     I
"    JKL
" In dvorak
"     C
"    HTN


" left: qwerty: j, dvorac h
nnoremap h <Left>
inoremap <C-j> <Left>
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
inoremap <C-l> <Right>
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
inoremap <C-i> <C-O>g<Up>
noremap <S-Up> <C-u>
inoremap <S-Up> <C-O><C-u>
noremap <S-c> <C-u>
inoremap <ESC><S-i> <C-O><C-u>
noremap <C-Up> gg
inoremap <C-Up> <C-O>gg
nnoremap <C-i> gg
nnoremap <ESC><C-i> <C-O>gg

" down: qwerty: k, dvorac t
nnoremap <Down> g<Down>
nnoremap t g<Down>
inoremap <C-k> <C-O>g<Down>
noremap <S-Down> <C-d>
inoremap <S-Down> <C-O><C-d>
noremap <S-t> <C-d>
inoremap <ESC><S-k> <C-O><C-d>
noremap <C-Down> G
inoremap <C-Down> <C-O>G
nnoremap <C-k> G
nnoremap <ESC><C-k> <C-O>G

" dvorak: k
" qwerty: v
nnoremap k v

" save by ctrl-s
inoremap <C-s> <C-O>:w<CR>
noremap <C-s> :w<CR>
" exit by ctrl-x
inoremap <C-x> <C-O>:q<CR>
noremap <C-x> :q<CR>
