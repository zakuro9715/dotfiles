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

repo() {
  name=$1
  if [[ -z "$name" ]];
  then
    echo "Usage: repo NAME" >&2
    return 1
  fi

  find "$GHQ_ROOT" -maxdepth 3 -mindepth 3 -print0 |
    while IFS= read -r -d '' repo; do
      if [[ "$name" == "$(basename $repo)" ]]
      then
        set-title $name
        cd $repo
        return 0
      fi
    done
}

zakuro() {
  cd $GHQ_ROOT/github.com/zakruo9715
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
