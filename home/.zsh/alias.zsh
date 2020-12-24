alias l="ls"

alias g="git"
alias gi="git"
alias gis="git status"
alias gid="git diff"
alias gil="git log"

alias mkdir="mkdir -p"
alias grep="grep --color"

alias rm="rm -r"
alias cp="cp -R"
alias diff="colordiff -u"
alias less="less -R"

alias bnudle="bundle"
alias be="bundle exec"
alias ber="bundle exec rails"
alias berc="bundle exec rails c"
alias bers="bundle exec rails s"

alias dc="docker-compose"

alias npm="npm --color=always"

alias s="serve"
alias c="git commit"
alias l="git l"
alias diff="git diff"
alias pso="git pso"
alias psof="git psof"
alias plom="git plom"

if iswsl
then
  alias clip-paste="powershell.exe 'Get-Clipboard'"
  alias clip="clip.exe"
fi
