# Load script and call command e.g.) load-then-call ~/.zsh/commands.zsh build-with-make
src=$1
shift
source $src && "$@"
