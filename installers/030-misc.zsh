#!/usr/bin/env zsh

basedir="$(cd $(dirname $0)/..; pwd)"
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
