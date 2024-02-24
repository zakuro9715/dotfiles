#!/usr/bin/env zsh

basedir="$(cd $(dirname $0)/..; pwd)"
github_dir="$(ghq root)/github.com"
zakuro="$github_dir/zakuro9715"
source "$basedir/deps.zsh"

cd "$zakuro/v"
make
sudo ./v symlink

ln -sf "$(pwd)/../v-zconfig/z.yaml" "$zakuro/v/z.yaml"

cd "$zakuro/z"
go build
./z symlink

sudo n latest

curl -fsSL https://deno.land/x/install/install.sh | sudo DENO_INSTALL=/usr/local sh
