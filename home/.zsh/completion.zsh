fpath=(
  "$GHQ_ROOT/github.com/zsh-users/zsh-completions/src",
  "/usr/share/git/completion",
  $fpath
)
autoload -U compinit && compinit

setopt list_packed
setopt magic_equal_subst
setopt auto_param_slash
setopt mark_dirs

# histroy completion
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

setopt share_history
setopt hist_ignore_dups  # Don't store a same command as last one.
setopt hist_ignore_all_dups  # Romove same comands as command to store
setopt append_history  # append not overwrite
setopt extended_history
setopt hist_ignore_space # Ignore if command is started with space
setopt hist_save_no_dups
