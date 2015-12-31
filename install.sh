#!/usr/bin/zsh

cat << EOS

      DDDDDDDD      OOOOOOO   TTTTTTTTTTT   FFFFFFFFF  IIIIIIIIIII   LL         EEEEEEEEEE   SSSSSSS
     DD      DD   OO      OO      TT       FF              II       LL         EE          SS
    DD      DD   OO      OO      TT       FF              II       LL         EE            SS
   DD      DD   OO      OO      TT       FFFFFFFFF       II       LL         EEEEEEEEEE       SS
  DD      DD   OO      OO      TT       FF              II       LL         EE                 SS
 DDDDDDDDD      OOOOOOO       TT       FF          IIIIIIIIIII  LLLLLLLLL  EEEEEEEEEE    SSSSSSS

####################################################################################################
EOS

for f in home/.*
do
  link="$HOME/${f##*/}"
  target="$(cd $(dirname $f) && pwd)/$(basename $f)"

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
    linux*)
      ln -sf "$target" "$link"
    ;;
  esac
done
