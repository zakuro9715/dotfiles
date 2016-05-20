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


cat << EOS

      DDDDDDDD      OOOOOOO   TTTTTTTTTTT   FFFFFFFFF  IIIIIIIIIII   LL         EEEEEEEEEE   SSSSSSS
     DD      DD   OO      OO      TT       FF              II       LL         EE          SS
    DD      DD   OO      OO      TT       FF              II       LL         EE            SS
   DD      DD   OO      OO      TT       FFFFFFFFF       II       LL         EEEEEEEEEE       SS
  DD      DD   OO      OO      TT       FF              II       LL         EE                 SS
 DDDDDDDDD      OOOOOOO       TT       FF          IIIIIIIIIII  LLLLLLLLL  EEEEEEEEEE    SSSSSSS

####################################################################################################
EOS

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
