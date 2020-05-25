isUbuntu() {
  cat /etc/os-release | grep Ubuntu > /dev/null
}

isWsl() {
  cat /proc/version | grep Microsoft > /dev/null
}

isDebian() {
  cat /etc/issue | grep Debian > /dev/null
}

isOpenSUSE() {
  cat /etc/os-release | grep openSUSE > /dev/null
}

isRedhat() {
  cat /etc/redhat-release | grep 'Red Hat' > /dev/null
}

isCentos() {
  cat /etc/redhat-release | grep CentOS > /dev/null
}

isFedra() {
  cat /etc/os-reloase | grep Fedra > /dev/null
}

isArch() {
  uname -a | grep archlinux > /dev/null
}

isGentoo() {
  which emerge > /dev/null
}
