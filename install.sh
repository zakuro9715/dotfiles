#!/bin/sh

require() {
  for cmd do
    if ! command -v "$cmd" >/dev/null 2>&1
    then
      printf 'required command "%s" not found\n' "$cmd" >&2
      return 1
    fi
  done
}

update() {
  sudo apt update -yq
}

install() {
  for cmd do
    if ! command -v "$cmd" >/dev/null 2>&1
    then
      printf 'installing required command "%s"\n' "$cmd" >&2
      sudo apt install -yqq "$cmd"
    fi
  done
}

ensure_dir() {
  mkdir -p "$1" || {
    printf 'failed to create directory "%s"\n' "$1" >&2
    return 1
  }
}
ensure_dir_repo() {
  if ! [ -d "$1" ]
  then
    git clone "$2" "$1"
  fi
}

must_cd() {
  cd "$1" || {
    printf 'failed to change directory to "%s"\n' "$1" >&2
    exit 1
  }
}

bootstrap=${1:-./bootstrap.zsh}
zakuro="$HOME/src/github.com/zakuro9715"
dotfiles="$zakuro/dotfiles"
repo=git@github.com:zakuro9715/dotfiles

require apt
update
install git zsh

ensure_dir "$zakuro"
ensure_dir_repo "$dotfiles" "$repo"
must_cd "$dotfiles"
"$bootstrap"
