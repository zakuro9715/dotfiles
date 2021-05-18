source "$HOME/.zsh/utils.zsh"
source "$HOME/.zsh/env.zsh"

ppa=(
  ppa:longsleep/golang-backports
)

apt=(
  tmux
  golang-go
  nodejs
  npm
  clang
  python3
  python3-pip
)

go=(
  github.com/x-motemen/ghq@latest
  golang.org/x/tools/cmd/goimports@latest
  github.com/mitranim/gow@latest
  github.com/motemen/gore/cmd/gore@latest
)

pip3=(
  'git+https://github.com/jeffkaufman/icdiff.git'
)

cargo=(
  ripgrep
  watchexec
)

ghq=(
  git@github.com:zakuro9715/dotfiles
  git@github.com:zakuro9715/z
  git@github.com:zakuro9715/v
  git@github.com:zakuro9715/v-zconfig
  git@github.com:tmux-plugins/tpm
)
