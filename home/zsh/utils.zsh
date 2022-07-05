truthy() {
  ! falsy $1
}

falsy() {
  [[ -z "$1" ]] || [[ "$1" == "false" ]] || [[ "$1" == "0" ]]
}

check-command() {
  type $1 &> /dev/null;
}

islinux() {
  [[ "$(uname)" == "Linux" ]]
}

is_wsl() {
  [[ "$(uname -a)" =~ "microsoft" ]]
}

iswindows() {
  is_wsl || [[ "$OS" == "Windows_NT" ]]
}

istmux() {
  test -n "$TMUX"
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
