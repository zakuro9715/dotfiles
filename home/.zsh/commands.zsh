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
