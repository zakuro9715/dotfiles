source "$HOME/.zsh/commands.zsh"

git-less-diff() {
  git diff "$@" -- ':!package-lock.json' ':!**/package-lock.json'
}
