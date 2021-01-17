reload() {
  source ~/.zshrc
  tmux source ~/.tmux.conf
}

set-title() {
  title=$@
  if [[ -z "$title" ]];
  then
    title="$(basename $(pwd))"
  fi
  echo -ne "\033]0;${title}\a"
}

find-repo() {
  target="$(echo "/$1" | sed 's/\/\+/\//g')"  # multi slash to single slash
  ghq list -p | grep --color=never -E "$target$" | head -n1
}

cd-repo() {
  repo=$1
  dir=$(find-repo $repo)
  if [[ "$dir" == "" ]]
  then
    echo "Repository $repo not found" >&2
    return 1
  fi

  set-title "$(basename $dir)"
  cd $dir
}


get-cd-repo() {
  repo="$1"
  dir="$(ghq get --silent -u $repo 2>&1 | grep -oE "$(ghq root)/.+$")"
  set-title "$(basename $dir)"
  cd "$dir"
}

repo() {
  mode="cd"
  case "$1" in
    "cd"  ) shift ;;
    "get" )
      mode="get"
      shift ;;
  esac

  if [[ -z "$1" ]];
  then
    echo "Usage: repo [get|cd] NAME" >&2
    return 1
  fi


  case "$mode" in
    "cd"  ) cd-repo "$1" ;;
    "get" ) get-cd-repo "$1" ;;
  esac
}

zakuro() {
  cd $GHQ_ROOT/github.com/zakuro9715
}

github() {
  cd $GHQ_ROOT/github.cow
}
gitlab() {
  cd $GHQ_ROOT/gitlab.com

}

use-short-prompt() {
  export SHORT_PROMPT='1'
}

use-long-prompt() {
  export SHORT_PROMPT=''
}

_shellcheck() {
  if type shellcheck > /dev/null
  then
    $bin $@
  else
    echo 'shellcheck not found' >&2
  fi
}

shellcheck-sh() {
  _shellcheck -s sh $@
}

shellcheck-bash() {
  _shellcheck -s bash $@
}

is_rails() {
  [ -e "Gemfile" ] && cat Gemfile | grep rails > /dev/null
}

is_django() {
  [ -e "manage.py" ] && cat manage.py | grep Django > /dev/null
}

is_node() {
  [ -e package.json ]
}

serve() {
  if is_rails
  then
    bundle exec rails s
  elif is_django
  then
    python manage.py runserver
  elif is_node
  then
    npm run serve
  fi

  echo "Failed to server detection"
}

cd-n() {
  SHELL_INIT="cd $@" $SHELL
}
