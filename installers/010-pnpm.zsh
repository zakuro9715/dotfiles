#!/usr/bin/env zsh

basedir="$(cd $(dirname $0)/..; pwd)"
source "$basedir/deps.zsh"
source "$HOME/.zsh/env.zsh"

curl -fsSL https://get.pnpm.io/install.sh | PNPM_NO_MODIFY_PATH=1 sh

for pkg in $pnpm
do
  pnpm -g install $pkg
  pnpm -g update $pkg
done

