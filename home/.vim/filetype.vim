aug filetype_detection
  au!

  au BufNewFile,BufRead *.s :set filetype=gas
  au BufNewFile,BufRead *.vue :set filetype=html
  au BufNewFile,BufRead *.zsh-theme :set filetype=zsh
  au BufNewFile,BufRead *.dockerfile :set filetype=dockerfile

  " JSON configuration files
  au BufNewFile,BufRead *.babelrc :set filetype=json
  au BufNewFile,BufRead *.stylelintrc :set filetype=json
  au BufNewFile,BufRead *.eslintrc :set filetype=json

  " Shell-like file
  au BufNewFile,BufRead *.envrc :set filetype=sh
aug END
