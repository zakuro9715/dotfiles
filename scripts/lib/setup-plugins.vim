function! s:setup_plugins()
  NeoBundleUpdate
  VisonSetup
  if has('nvim')
    NeoBundleRemotePlugins
  endif
endfunction

command! SetupPlugins :call s:setup_plugins()
