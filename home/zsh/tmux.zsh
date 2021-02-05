TPM_DIR="$HOME/src/github.com/tmux-plugins/tpm"

tpm-install() {
  $TPM_DIR/bindings/install_plugins
}

tpm-update() {
  $TPM_DIR/bindings/update_plugins
}

tpm-clean() {
  $TPM_DIR/bindings/clean_plugins
}

tmux-current-window-i() {
  echo $(( $(tmux list-window | grep -n '(active)' | cut -f 1 --delim=':') - 1 ))
}

tmux-window-count() {
  tmux list-window | wc -l
}

tmux-move-window-first() {
  i=$(tmux-current-window-i)
  for _ in $(seq $i)
  do
    tmux swap-window -t -1
  done
}

tmux-move-window-last() {
  i=$(tmux-current-window-i)
  n=$(tmux-window-count)
  for i in $(seq $((n - i - 1)))
  do
    tmux swap-window -t +1
  done
}
