#/usr/bin/env zsh

cd $(ghq root)/github.com/zakuro9715/v
make
sudo v symlink

ln -s $(pwd)/../v-zconfig/z.yaml
