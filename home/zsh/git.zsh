source "$HOME/.zsh/commands.zsh"

git-install-hooks() {
  ln -sf ~/.git_hooks/* "$(git root)/.git/hooks/"
}

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
  remote="$1"
  if [[ "$remote" == "all" ]]
  then
    for v in $(git remote)
    do
      git-clear "$v"
    done
    return
  fi

  if [[ -z "$remote" ]]
  then
    branches=$(git branch)
  else
    branches=$(git branch --remote | grep "$remote/")
  fi
  branches=$(echo $branches | grep -v "$(git-default-branch)" | grep -v "HEAD" | grep -v '*' | sed 's/ //g')

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
      if [[ -z "$remote" ]]
      then
        git branch -D $(echo $branches)
      else
        git push -d $remote $(echo $branches | sed 's#origin/##g')
      fi
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

git-pretty-stash() {
  command="$1"
  case "$1" in
    'list' )
       shift
       git stash list $@ | sed 's/\(stash@[^:]*\).*name:\(.*\)/\1: \2/'
       return
      ;;
    'show' | 'push' | 'apply' | 'pop' | 'drop' )
      shift
      ;;
    * )
      command='push'
  esac

  flags=()
  while echo "$1" | grep "^-" > /dev/null
  do
    flags=($flags "$1")
    shift
  done

  name="$1"
  if [ -z "$name" ]
  then
    git stash "$command"
    return
  fi

  msg="name:$name"
  shift
  case "$command" in
    'push' )
      git stash "$command" -m "$msg" "${flags[@]}" $@
      ;;
    'pop' | 'apply' | 'drop' | 'show' )
      id="$(git stash list | grep "$msg\$" | cut -d ':' -f 1)"
      if [ -z "$id" ]
      then
        echo "`name:$name` does not exist in stash" 1>&2
        return 1
      fi
      git stash "$command" "${flags[@]}" "$id"
      ;;
    * )
      git stash "$command" "${flags[@]}" $@
      ;;
  esac
}
