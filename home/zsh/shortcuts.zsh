function ghq-repos() {
  local selected_dir=$(ghq list | peco)
  if [ -n "$selected_dir" ]; then
    BUFFER="$BUFFER ${GOPATH}/src/${selected_dir}"
  fi
  zle redisplay
}
zle -N ghq-repos
stty -ixon
bindkey '^gr' ghq-repos
