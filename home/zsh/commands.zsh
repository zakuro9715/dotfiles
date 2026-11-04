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
  local target="$(echo "$1" | sed 's/\/\+/\//g')"  # multi slash to single slash
  local repo="$(list-repo | fzf -0 -1 -q "'$target")"
  if [[ -n "$repo" ]]
  then
    echo "$repo"
    return 0
  fi

  echo "Not found on Linux" >&2
  echo "Searching on windows. Wait a minute." >&2
  list-win-repo | fzf -0 -1 -q "'$target"
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
  cd $ZAKURO
}

github() {
  cd $GITHUB
}

gitlab() {
  cd $GHQ_ROOT/gitlab.com

}

upfind () {
  if [[ -e "$1" ]]
  then
    print "$1"
    return 0
  fi
  upfind "../$1"
}

upcd() {
  cd "$(upfind "$1")"
}

_is-worktree-subcommand() {
  case "$1" in
    "rm"|"brm")
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

worktree() {

  case "$1" in
    "--")
      shift
      ;;
    "root")
      cd "$(git worktree list | grep "$(git default-branch)" | awk '{print $1}')"
      return $?
      ;;
    "add"|"list"|"lock"|"prune"|"move"|"remove"|"repair"|"unlock")
      git worktree $@
      return $?
      ;;
  esac

  branch=$1
  cmd=''

  if [[ "$1" == "root" ]]
  then
    cd "$(git worktree list | grep "$(git default-branch)" | awk '{print $1}')"
    return $?
  fi

  if _is-worktree-subcommand "$1"
  then
    cmd="$1"
    branch="$2"
  fi

  # worktree
  if [[ -z "$branch" ]]
  then
    echo "branch name is required" >&2
    return 1
  fi


  # worktree subcommand
  case "$cmd" in
    "brm")
      git worktree remove "$branch"
      cd "$(dirname "$(upfind .git)")"
      git bad "$branch"
      return 0
      ;;
    "rm")
      echo "rm"
      git worktree remove "$branch"
      return 0
      ;;
    *)
      ;;
  esac


  # worktree branch
  if git worktree list | grep "$branch" > /dev/null
  then
    # worktree exists
    :
  elif git rev-parse --verify -q "$branch" > /dev/null
  then
    # branch exists
    git wa "$branch"
  else
    # branch and worktree not exists
    git wb "$branch"
  fi
  cd "$(git wt-dir "$branch")"
}
alias root='cd "$(git root)"'

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

dus() {
  if [ $# -eq 0 ]
  then
    set -- *
  fi
  du -sh "$@" | sort -h
}
alias print-size="dus"

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
