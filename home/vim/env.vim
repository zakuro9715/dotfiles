function! s:is_wsl() abort
  let path = '/proc/version'
  if filereadable(path)
    let lines = readfile(path)
    return lines[0] =~ "Microsoft"
  endif
  return v:false
endfunction

let g:is_wsl = s:is_wsl()
