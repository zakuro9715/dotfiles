export PATH="/usr/local/bin:/usr/bin:/bin"  # Reset PATH

if is_wsl
then
  export PATH="$PATH:/mnt/c/Windows/System32:/mnt/c/Windows/System32/WindowsPowerShell/v1.0"
  export PATH="$PATH:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/ProgramData/DockerDesktop/version-bin"
  alias code="'/mnt/c//Users/z/AppData/Local/Programs/Microsoft VS Code/bin/code'"
  export BROWSER="powershell.exe /c open"
fi

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export EDITOR=vim
export SHELL="$(which zsh)"
export GOPATH="$HOME"
export GHQ_ROOT="$HOME/src"
export GHQ_GITHUB="$GHQ_ROOT/github.com"
export GHQ_ZAKURO="$GHQ_ROOT/github.com/zakuro9715"
export GITHUB_USER="zakuro9715"
export GO111MODULE=on
export VFLAGS='-cc clang'
export VREPO="$GHQ_ZAKURO/v"
export PATH="$GOPATH/bin:$HOME/.cargo/bin:$HOME/.dotnet:$HOME/.local/bin:$HOME/.local/share/pnpm:$HOME/.opam/default/bin:$PATH"
export TERM="xterm-256color"
export NODE_OPTIONS="--max-old-space-size=4096"
export COLOR="--color=always"
export GPG_TTY=$(tty)
