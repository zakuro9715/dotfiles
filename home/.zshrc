source "$HOME/.zsh/utils.zsh"
source "$HOME/.zsh/alias.zsh"
source "$HOME/.zsh/commands.zsh"
source "$HOME/.zsh/shortcuts.zsh"

bindkey -e  # I'm vimmer but emacs bind is useful more than vim bind.
autoload -Uz add-zsh-hook
eval $(dircolors -b)

# Env
# ===

export PATH="/usr/local/bin:/usr/bin:/bin"  # Reset PATH

export LANG=ja_JP.UTF-8
export EDITOR=vim
export GIT_GUI=gitg
export GOPATH="$HOME"
export GHQ_ROOT="$HOME/src"
export PATH="$GOPATH/bin:$PATH"
export TERM="xterm-256color"
export XDG_CONFIG_HOME="$HOME/.config"


# PROMPT
# ======

source "$GHQ_ROOT/github.com/zakuro9715/zakuroster/zakuroster.zsh"


# Color
# =====
autoload -U colors && colors


# Completion
# ==========

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



# OS-specific configuration
# =========================

os_specific_file="$HOME/.zsh/$(os).zsh"

if [[ -f "$os_specific_file" ]]
then
  source "$os_specific_file"
else
  echo "WARNING: $os_specific_file not found"
fi


# host-specific configuration
# ===========================

host_specific_file="$HOME/.zsh/$(hostname).zsh"
if [[ -f "$host_specific_file" ]]
then
  source "$host_specific_file"
else
  echo "WARNING: $host_specific_file not found"
fi


# Secret configuration(Password, Authtoken, etc...)
# =================================================
secret_file="$HOME/.zsh/secret.zsh"
if [[ -f "$secret_file" ]]
then
  source "$secret_file"
fi


# Applications
# ============

# pyenv
export PYENV_ROOT="$GHQ_ROOT/github.com/yyuu/pyenv"
if [[ -d "$PYENV_ROOT" ]]
then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
else
  echo 'pyenv not found'
fi

# pyvenv
PYVENV_DIRS=('.' 'venv')
check-pyvenv() {
  if [[ -n "$VIRTUAL_ENV" ]];
  then
    case "$(pwd)" in
      $VIRTUAL_ENV* ) ;; # In venv
      *             ) deactivate ;;
    esac
  else
    for dir in ${PYVENV_DIRS[@]}
    do
      if [[ -r "$dir/bin/activate" ]]
      then
        source "$dir/bin/activate"
        break
      fi
    done
  fi
}

add-zsh-hook chpwd check-pyvenv

# rbenv
export RBENV_ROOT="$GHQ_ROOT/github.com/rbenv/rbenv"
if [[ -d "$RBENV_ROOT" ]]
then
  export PATH="$RBENV_ROOT/bin:$PATH"
  eval "$(rbenv init -)"
else
  echo 'rbenv not found'
fi

# nvm
export NVM_DIR="$GHQ_ROOT/github.com/creationix/nvm"
if [[ -d "$NVM_DIR" ]]
then
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
else
  echo 'nvm not found'
fi

# direnv
if check-command direnv
then
  eval "$(direnv hook zsh)"
else
  echo 'direnv not found'
fi

# hub
if check-command hub
then
  eval "$(hub alias -s)"
  compdef hub=git
else
  echo 'hub not found'
fi

do_enter() {
  if [ -n "$BUFFER" ]; then
    zle accept-line
    return 0
  fi
  zle reset-prompt
  return ls
}
zle -N do_enter
bindkey '^m' do_enter

# gcloud sdk
export GCLOUD_SDK_ROOT="$HOME/google-cloud-sdk"
if [[ -d "$GCLOUD_SDK_ROOT" ]]
then
  source "$GCLOUD_SDK_ROOT/path.zsh.inc"
  source "$GCLOUD_SDK_ROOT/completion.zsh.inc"
fi

# appengine
export GO_APPENGINE_ROOT="$HOME/go_appengine"
if [[ -d "$GO_APPENGINE_ROOT" ]]
then
  export PATH="$GO_APPENGINE_ROOT:$PATH"
fi

# added by travis gem
[ -f /home/zakuro/.travis/travis.sh ] && source /home/zakuro/.travis/travis.sh
