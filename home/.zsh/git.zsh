source "$HOME/.zsh/commands.zsh"

git-less-diff() {
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
