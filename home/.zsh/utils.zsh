check-command() {
  type $1 &> /dev/null;
}

islinux() {
  [[ "$(uname)" == "Linux" ]]
}

iswindows() {
  [[ "$OS" == "Windows_NT" ]]
}

os() {
  if islinux
  then
    echo "linux"
  elif iswindows
  then
    echo "windows"
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
