update-git-hooks () {
  hooks_dir=~/.git_template/hooks

  for repo in $(ghq list zakuro)
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
    return 0
  fi
  git config --local user.email $new_email
  echo "Old email is ${old_email:-[empty]}."
  echo "New email is $new_email."
}
