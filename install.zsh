#!/usr/bin/zsh

create-symlink() {
  link=$1
  target=$2

  if [[ -e $link ]]
  then
    echo "Removing $link"
    rm "$link" -r
  fi
  echo "Creating $link"
  case ${OSTYPE} in
    msys*)
      link="%USERPROFILE%/${f##*/}"
      target="C:\\wnix\\${target:gs/\//\\/}"
      cmd /c "mklink \"$link\" \"$target\""
    ;;
    *)
      ln -sf "$target" "$link"
    ;;
  esac
}


install-full() {
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
}

install-slim() {
  cat << EOS
ddd   oo  ttttt ffff iiiii l     eeeee  sss
d  d o  o   t   f      i   l     e     s
d  d o  o   t   ffff   i   l     eeee   sss
d  d o  o   t   f      i   l     e         s
ddd   oo    t   f    iiiii lllll eeeee  sss   slim version
----------------------------------------------------------
EOS

  for f in home/.*-slim*
  do
    link="$HOME/$(basename $f | sed s/-slim//)"
    target="$(cd $(dirname $f) && pwd)/$(basename $f)"
    create-symlink $link $target
  done
}


if [[ $# -ne 1 ]]
then
  echo "Usage: zsh install.zsh TARGET"
  exit 1
fi

case $1 in
  full) install-full ;;
  slim) install-slim ;;
  *   ) echo "unknown target" ;;
esac
