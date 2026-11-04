#!/usr/bin/env zsh

basedir="$(cd $(dirname $0)/..; pwd)"
source "$basedir/deps.zsh"

curl -fsSL https://github.com/skilld-dev/skilld/releases/latest/download/install.sh
curl -fsSL https://gh.io/copilot-install | bash
