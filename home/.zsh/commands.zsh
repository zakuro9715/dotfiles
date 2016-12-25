update-git-hooks () {
  hooks_dir=~/.git_template/hooks

  for repo in $(ghq list)
  do
    target_dir=$GHQ_ROOT/$repo/.git/hooks
    rm $target_dir
    cp $hooks_dir $target_dir -R
  done
}

irsync() {
  do-rsync() {
    echo "$ rsync $@"
    rsync $@ | while read line; do echo "[rsync] $line"; done
  }

  sync-loop() {
    do-rsync $@
    while read msg
    do
      echo "[inotifywait] $msg"
      do-rsync $@
    done
  }

  local src=${@:$(($# - 1)):1} # The second last element of arguments
  local dest=${@:$#:1}         # The last element of arguments

  local inotify_actions=${IRSYNC_ACTIONS:-modify,attrib,move,create,delete}
  local inotify_options=${IRSYNC_INOTIFY_OPTIONS:--mr}

  echo "$ inotifywait -e $inotify_actions $inotify_options $src"
  zsh -c "inotifywait -e $inotify_actions $inotify_options $src" | sync-loop $@

  unset do-rsync
  unset sync-loop
}

can-build-with-docker-compose() {
  test -f 'docker-compose.yml'
}

build-with-docker-compose() {
  docker-compose build
}

can-build-with-make() {
  test -f 'Makefile'
}

build-with-make() {
  make
}

can-build-with-npm() {
  test -f 'package.json'
}

build-with-npm() {
  npm run build
}

build-with-appropriate-way() {
  ways=(docker-compose make npm)

  for way in $ways
  do
    if can-build-with-${way}
    then
      echo "build with ${way}"
      build-with-${way}
      return
    fi
  done

  echo "Can't detect appropriate building way" >&2
  return 1
}
