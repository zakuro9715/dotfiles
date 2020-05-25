source "$HOME/.zsh/os-detection.zsh"

check-command() {
  type $1 &> /dev/null;
}

islinux() {
  [[ "$(uname)" == "Linux" ]]
}

iswsl() {
  uname -a | grep "Microsoft" > /dev/null
}

iswindows() {
  iswsl || [[ "$OS" == "Windows_NT" ]]
}

os() {
  if iswindows
  then
    echo "windows"
  elif islinux
  then
    echo "linux"
  fi
}

log-error() {
  local message="ERROR: $1"
  echo -e "\e[1;31m$message\e[m"
}

log-warning() {
  local message="WARNING: $1"
  echo -e "\e[;33m$message\e[m"
}

log-info() {
  local message="INFO: $1"
  echo $message
}

log-success() {
  local message="$1"
  echo -e "\e[1;32m$message\e[m"
}
