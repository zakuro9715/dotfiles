reload() {
  source ~/.zshrc
}

set-title() {
  title=$@
  if [[ -z "$title" ]];
  then
    title="$(basename $(pwd))"
  fi
  echo -ne "\033]0;${title}\a"
}
