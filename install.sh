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

  echo "Removing $link"
  rm "$link" -r

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


install-packages() {
  source "$HOME/.zsh/utils.zsh"
  install=''
  index=0

  if check-command 'apt-get'
  then
    echo 'apt-get detected'
    index=1
    install='sudo apt-get install -y'
  else
    echo 'Unknown pcakage manager'
    return 1
  fi

  for line in $(cat  'packages.csv' | grep -v ^#)
  do
    install="$install $(echo $line | cut -d ',' -f $index)"
  done
  eval $install
}
install-packages
