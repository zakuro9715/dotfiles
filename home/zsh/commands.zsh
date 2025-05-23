source "$HOME/.zsh/utils.zsh"
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

list-win-repo() {
  find /mnt/e/src -name .git | sed 's#/.git$##'
}

list-repo() {
  # ghq list
  # | prepend number to sort
  # | update number of zakuro's repository
  # | sort
  # | remove prefix number
  ghq list -p \
    | sed 's/^/100 /g' \
    | sed -E 's#^(100) (.*/)(zakuro9715)(/.*)$#000 \2\3\4#g' \
    | sort \
    | sed -E 's/^.{4}//g'
}

find-repo() {
  local target="$(echo "/$1" | sed 's/\/\+/\//g')"  # multi slash to single slash
  local repo="$(list-repo | grep "$target$" | head -n1)"
  if [[ -n "$repo" ]]
  then
    echo "$repo"
    return 0
  fi

  echo "Not found on Linux" >&2
  echo "Searching on windows. Wait a minute." >&2
  list-win-repo | grep "$target$" | head -n1
}

cd-set-title-tmux() {
  dir=$1
  cd $dir
  set-title
  if [ -z "$TMUX" ]
  then
    tmux
  fi
}

cd-repo() {
  repo=$1
  dir=$(find-repo $repo)
  if [[ "$dir" == "" ]]
  then
    echo "Repository $repo not found" >&2
    return 1
  fi
  cd-set-title-tmux "$dir"
}


get-cd-repo() {
  repo="$1"
  ghq get -u -p $repo
  dir=$(find-repo $repo)
  cd-set-title-tmux "$dir"
}

create-cd-repo() {
  repo="$1"
  dir="$GHQ_ROOT/github.com/zakuro9715"
  cd $dir
  gh repo create $repo -y
  cd-set-title-tmux "$repo"
}

repo() {
  mode="cd"
  case "$1" in
    "cd"  ) shift ;;
    "get" )
      mode="get"
      shift ;;
    "create")
      mode="create"
      shift ;;
  esac

  if [[ -z "$1" ]];
  then
    echo "Usage: repo [get|cd] NAME" >&2
    return 1
  fi


  case "$mode" in
    "cd"     ) cd-repo "$1" ;;
    "get"    ) get-cd-repo "$1" ;;
    "create" ) create-cd-repo "$1" ;;
  esac
}

zakuro() {
  cd $GHQ_ROOT/github.com/zakuro9715
}

github() {
  cd $GHQ_ROOT/github.com
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

open-localhost() {
  port=$([[ -n "$1" ]] && echo "$1" || echo '8000')
  open "http://localhost:$port"
}

alias openlh="open-localhost"

cd-n() {
  SHELL_INIT="cd $@" $SHELL
}

v-wrapper() {
  if truthy "$VMASTER"
  then
    $VREPO/vmaster "$@"
  else
    $VREPO/v "$@"
  fi
}

repl() {
  if [ "$#" -lt 1 ] || [ "${1:0:1}" = '-' ]
  then
    if [ -f "go.mod" ]
    then
      lang="go"
    elif [ -f "Cargo.toml" ]
    then
      lang="rust"
    elif [ -f "v.mod" ]
    then
      lang="v"
    else
      echo "Cannot detect language" >&2
      return 1
    fi
  else
    lang="$1"
    shift
  fi

  case "$lang" in
    go  ) gore $@;;
    rust) evcxr $@;;
    v   ) v repl $@;;
    *   )
      echo "No repl for $lang" >&2
      return 1;;
  esac
}
