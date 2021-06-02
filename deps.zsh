source "$HOME/.zsh/utils.zsh"
source "$HOME/.zsh/env.zsh"

ppa=(
  ppa:longsleep/golang-backports
)

apt=(
  language-pack-ja
  tmux
  direnv
  golang-go
  nodejs
  npm
  jq
  clang
  python3
  python3-pip
  grip
  ubuntu-wsl
)

go=(
  github.com/x-motemen/ghq@latest
  golang.org/x/tools/cmd/goimports@latest
  github.com/mitranim/gow@latest
  github.com/motemen/gore/cmd/gore@latest
  github.com/charmbracelet/glow@latest
  github.com/MichaelMure/mdr@latest
)

go_get=(
  github.com/wagoodman/dive
)

pip3=(
  'git+https://github.com/jeffkaufman/icdiff.git'
)

npm=(
)

cargo=(
  ripgrep
  watchexec-cli
)

ghq=(
  git@github.com:zakuro9715/dotfiles
  git@github.com:zakuro9715/z
  git@github.com:zakuro9715/v
  git@github.com:zakuro9715/v-zconfig
  git@github.com:tmux-plugins/tpm
)
