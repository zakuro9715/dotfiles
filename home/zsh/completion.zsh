autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history

setopt always_last_prompt
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt brace_ccl
setopt complete_in_word
setopt extended_glob
setopt globdots
setopt list_types
setopt magic_equal_subst
setopt mark_dirs
