export PATH="/usr/local/bin:/usr/bin:/bin"  # Reset PATH

if iswsl
then
  export PATH="$PATH:/mnt/c/Windows/System32:/mnt/c/Windows/System32/WindowsPowerShell/v1.0"
  export PATH="$PATH:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/ProgramData/DockerDesktop/version-bin"
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
export GO111MODULE=on
export VFLAGS='-cc clang'
export VREPO="$GHQ_ZAKURO/v"
export PATH="$GOPATH/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export TERM="xterm-256color"
export NODE_OPTIONS="--max-old-space-size=4096"
export COLOR="--color=always"
