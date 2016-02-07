export ZSH="$HOME/.oh-my-zsh"

source "$HOME/.zsh/utils.zsh"
source "$HOME/.zsh/alias.zsh"
source "$HOME/.zsh/commands.zsh"

export PATH="/usr/local/bin:/usr/bin:/bin"  # Reset PATH


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


# Env
# ===

export EDITOR=vim
export GIT_GUI=gitg
export GOPATH="$HOME"
export GHQ_ROOT="$HOME/src"
export PATH="$GOPATH/bin:$PATH"
export XDG_CONFIG_HOME="$PATH/.config"

export IRSYNC_INOTIFY_OPTIONS="-mr --exclude='.git'"


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
check_pyvenv() {
  if [[ -n "$VIRTUAL_ENV" ]];
  then
    case "$(pwd)" in
      $VIRTUAL_ENV* ) ;; # In venv
      *             ) deactivate ;;
    esac
  elif [[ -r 'bin/activate' ]];
  then
    source 'bin/activate'
  elif [[ -r 'venv/bin/activate' ]];
  then
    source 'venv/bin/activate'
  fi
}

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
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
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
else
  echo 'hub not found'
fi

chpwd() {
  check_pyvenv
}

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


# oh-my-zsh
# =========

ZSH_CUSTOM="$HOME/github"
ZSH_THEME="zakuroster/zakuroster"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)


source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"






# added by travis gem
[ -f /home/zakuro/.travis/travis.sh ] && source /home/zakuro/.travis/travis.sh
