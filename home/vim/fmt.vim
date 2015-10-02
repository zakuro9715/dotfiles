autocmd BufWritePre *.go Fmt
autocmd BufWritePre * call s:remove_tailing_whitespaces()

function! s:remove_tailing_whitespaces()
  %s/\s\+$//e
endfunction
