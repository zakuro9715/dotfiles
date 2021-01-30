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
