alias l="ls"
alias grep="rg"
alias gp="grep"
alias mkdir="mkdir -p"
alias bat="batcat"

alias rm="rm -r"
alias cp="cp -R"
alias diff="delta"
alias less="less -R"

alias bnudle="bundle"
alias be="bundle exec"
alias ber="bundle exec rails"
alias berc="bundle exec rails c"
alias bers="bundle exec rails s"

alias dc="docker-compose"
alias docker-dive="dive"

alias npm="npm --color=always"

alias c="git c"
alias s="git s"
alias g="git"
alias d="git d"
alias ba="git ba"
alias ad="git ad"
alias add="git add"
alias h="z"
alias vv="z --config=$(find-repo v-zconfig)/z.yaml"
alias t="z test"

if iswsl
then
  alias clip-paste="powershell.exe 'Get-Clipboard'"
  alias clip="clip.exe"
  alias open="powershell.exe /c start"
fi
