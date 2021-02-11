:command! Error LspNextError
:command! Warn LspNextWarning
:command! Diag LspNextDiagnostic
:command! Hover LspHover

function! s:npm_lint()
  call system('npm run lint -- ' . expand('%'))
  execute ':e'
endfunction
:command! NpmLint call s:npm_lint()

:command! Reload :source ~/.vimrc
