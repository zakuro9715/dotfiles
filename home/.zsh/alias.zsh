alias ls="ls --color=auto"
alias l="ls"
alias la="ls -a"
alias lal="ls -al"
alias ll="ls -l"

alias mkdir="mkdir -p"
mkcd() { mkdir $1 && cd $1 }

alias rm="rm -r"

alias bnudle="bundle"
alias he="bundle exec"
alias her="bundle exec rails"
alias herc="bundle exec rails c"
alias hers="bundle exec rails s"

alias dc="docker-compose"
alias gi="git"
alias nim="nvim"

alias chown-me="sudo chown zakuro:zakuro"
alias xmm="xmodmap ~/.xmodmap"

if check-command colordiff
then
  alias diff="colordiff -u"
else
  alias diff="diff -u"
fi
