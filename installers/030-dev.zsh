#/usr/bin/env zsh

basedir="$1"
source "$basedir/deps.zsh"

vdir=$(ghq root)/github.com/zakuro9715/v
cd $vdir
make
sudo ./v symlink

ln -sf "$(pwd)/../v-zconfig/z.yaml" "$vdir/z.yaml"
