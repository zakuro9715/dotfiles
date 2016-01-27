update-git-hooks () {
  hooks_dir=~/.git_template/hooks

  for repo in $(ghq list)
  do
    target_dir=$GHQ_ROOT/$repo/.git/hooks
    rm $target_dir
    cp $hooks_dir $target_dir -R
  done
}

update-git-email () {
  old_email="$(git config --local user.email)"
  new_email="$GIT_EMAIL"
  if [[ $old_email == $new_email ]]
  then
    echo "No need to update."
    return 1
  fi
  git config --local user.email $new_email
  echo "Old email is ${old_email:-[empty]}."
  echo "New email is $new_email."
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
