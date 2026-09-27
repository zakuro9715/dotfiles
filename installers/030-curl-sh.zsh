#!/usr/bin/env zsh

basedir="$(cd $(dirname $0)/..; pwd)"
source "$basedir/deps.zsh"

curl -fsSL https://deno.land/x/install/install.sh | sh -s -- --no-modify-path -y
curl -fsSL https://github.com/skilld-dev/skilld/releases/latest/download/install.sh
