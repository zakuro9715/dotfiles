fpath=(
  "$GHQ_ROOT/github.com/zsh-users/zsh-completions/src",
  "/usr/share/git/completion",
  $fpath
)
autoload -U compinit && compinit

zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select=2

zstyle ':completion:*' completer _oldlist _complete _match _history _ignored _approximate _prefix
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

setopt no_beep
setopt no_match
setopt list_packed
setopt magic_equal_subst
setopt auto_param_slash
setopt mark_dirs
