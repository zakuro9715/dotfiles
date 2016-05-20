#!/usr/bin/zsh

create-symlink() {
  link=$1
  target=$2

  if [[ -e $link ]]
  then
    echo "Removing $link"
    rm -r "$link"
  fi
  echo "Creating $link"
  ln -sf "$target" "$link"
}

for f in home/.[!.]*
do
  link="$HOME/${f##*/}"
  target="$(cd $(dirname $f) && pwd)/$(basename $f)"
  create-symlink $link $target
done

for f in xdg_home/*
do
  link="${XDG_CONFIG_HOME:-$HOME/.config}/${f##*/}"
  target="$(cd $(dirname $f) && pwd)/$(basename $f)"
  create-symlink $link $target
done
