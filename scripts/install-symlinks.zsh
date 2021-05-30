basedir="$(dirname $(dirname $0))"
source "$basedir/home/zsh/utils.zsh"

create-symlink() {
  target=$1
  link=$2
  issudo=$3

  if [[ -e $link ]]
  then
    log-info "Removing $link"
    if [[ -n $issudo ]]
    then
      sudo rm -r "$link"
    else
      rm -r "$link"
    fi
  fi

  log-info "Creating $link"
  if [[ -n $issudo ]]
  then
    sudo ln -sf "$target" "$link"
  else
    ln -sf "$target" "$link"
  fi
}

for f in home/*
do
  link="$HOME/.${f##*/}"
  target="$(cd $(dirname $f) && pwd)/$(basename $f)"
  create-symlink $target $link
done

mkdir -p $HOME/.config
for f in config/*
do
  link="$HOME/.config/${f##*/}"
  target="$(cd $(dirname $f) && pwd)/$(basename $f)"
  create-symlink $target $link
done
