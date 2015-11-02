#!/usr/bin/zsh
for f in home/*
do
  link="$HOME/.${f##*/}"
  target="$(cd $(dirname $f) && pwd)/$(basename $f)"
  
  rm "$link" -r
  
  case ${OSTYPE} in
    msys*)
      link="%USERPROFILE%/.${f##*/}"
      target="C:\\wnix\\${target:gs/\//\\/}"
      cmd /c "mklink \"$link\" \"$target\""
    ;;
    linux*)
    echo QTESTT
      ln -sf "$target" "$link"
    ;;
  esac
done
