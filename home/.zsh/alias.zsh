alias ls="ls --color=auto"
alias l="ls"

alias mkdir="mkdir -p"

alias rm="rm -r"
alias cp="cp -R"

alias bnudle="bundle"
alias be="bundle exec"
alias ber="bundle exec rails"
alias berc="bundle exec rails c"
alias bers="bundle exec rails s"

alias dc="docker-compose"

if check-command colordiff
then
  alias diff="colordiff -u"
else
  alias diff="diff -u"
fi

alias emenv="source ~/src/github.com/emscripten-core/emsdk/emsdk_env.sh"
