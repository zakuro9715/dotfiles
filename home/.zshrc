source "$HOME/.zsh/utils.zsh"
source "$HOME/.zsh/colors.zsh"
source "$HOME/.zsh/alias.zsh"
source "$HOME/.zsh/commands.zsh"
source "$HOME/.zsh/git.zsh"
source "$HOME/.zsh/shortcuts.zsh"
source "$HOME/.zsh/prompt.zsh"
source "$HOME/.zsh/completion.zsh"

bindkey -e  # I'm vimmer but emacs bind is useful more than vim bind.
bindkey -r "^j"
autoload -Uz add-zsh-hook
eval $(dircolors -b)

# Env
# ===

export PATH="/usr/local/bin:/usr/bin:/bin"  # Reset PATH

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export EDITOR=vim
export SHELL="$(which zsh)"
export GOPATH="$HOME"
export GHQ_ROOT="$HOME/src"
export GO111MODULE=on
export VFLAGS='-cc clang'
export PATH="$GOPATH/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export TERM="xterm-256color"
export NODE_OPTIONS="--max-old-space-size=4096"
export COLOR="--color=always"


# Color
# =====
autoload -U colors && colors

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

# pyenv
export PYENV_ROOT="$GHQ_ROOT/github.com/pyenv/pyenv"
if [[ -d "$PYENV_ROOT" ]]
then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
else
  echo 'pyenv not found'
fi

# direnv
if check-command direnv
then
  eval "$(direnv hook zsh)"
else
  echo 'direnv not found'
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
