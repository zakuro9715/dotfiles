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
