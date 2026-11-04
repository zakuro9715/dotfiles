#!/usr/bin/env zsh

basedir="$(cd $(dirname $0)/..; pwd)"
source "$basedir/deps.zsh"
source "$HOME/.zsh/env.zsh"

npx get-pnpm --no-modify-path

for pkg in $pnpm
do
  pnpm -g install $pkg
  pnpm -g update $pkg
done

