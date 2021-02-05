source "$HOME/.zsh/commands.zsh"

git-custom-diff() {
  git diff "$@" -- ':!package-lock.json' ':!**/package-lock.json'
}

red='%C(204)'
green='%C(78)'
blue='%C(75)'
yellow='%C(222)'

#                        hash
pretty_log_format_base="${yellow}%h ${green}%cd ${blue}%<(10,trunc)%aN %Creset%<(20)%s ${red}%d"

git-pretty-log() {
  git -c color.ui="always" log \
    --date='format:%m/%d' \
    --pretty="tformat:$pretty_log_format_base" | less -R
}

git-pretty-graph-log() {
  git -c color.ui="always" log \
    --date='format:%m/%d' --graph \
    --pretty="tformat:%x09$pretty_log_format_base" | less -R
}

git-clear() {
  b="$(git-default-branch)"
  branches=$(git branch | grep -v "$(git-default-branch)" | grep -v '*' | sed 's/ //g')
  if [ -z "$branches" ]
  then
    echo "Nothing to do"
    return 0
  fi
  echo "Following branches will be deleted"
  echo "$branches" | sed 's/\(.*\)/- \1/g'
  printf "Are you sure? (y/N): "
  read c
  case "$c" in
    y)
      git branch -D $(echo $branches)
      return 0
      ;;
    *)
      echo 'Canceled'
      return 1
      ;;
  esac
}

git-default-branch() {
  if [ -n "$GIT_DEFAULT_BRANCH" ]
  then
    echo "$GIT_DEFAULT_BRANCH"
    return
  fi
  branches="$(git branch --format='%(refname:lstrip=2)')"
  defaults=('development' 'dev' 'main' 'master')
  for b in $defaults
  do
    if echo $branches | grep "^$b\$" > /dev/null
    then
      echo $b
      return
    fi
  done
  echo 'main'
}
