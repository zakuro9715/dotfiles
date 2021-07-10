#!/usr/bin/env zsh

basedir="$(cd $(dirname $0)/..; pwd)"
echo "$basedir/deps.zsh"
source "$basedir/deps.zsh"

vdir=$(ghq root)/github.com/zakuro9715/v
cd $vdir
make
sudo ./v symlink

ln -sf "$(pwd)/../v-zconfig/z.yaml" "$vdir/z.yaml"

zdir=$(ghq root)/github.com/zakuro9715/z
cd $zdir
go build
./z symlink

sudo n latest

curl -fsSL https://deno.land/x/install/install.sh | sudo DENO_INSTALL=/usr/local sh
