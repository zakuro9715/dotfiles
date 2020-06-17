basedir=$(dirname $0)
source "$basedir/home/.zsh/utils.zsh"

show-welcome-message() {
  cat << EOS

      DDDDDDDD      OOOOOOO   TTTTTTTTTTT   FFFFFFFFF  IIIIIIIIIII   LL         EEEEEEEEEE   SSSSSSS
     DD      DD   OO      OO      TT       FF              II       LL         EE          SS
    DD      DD   OO      OO      TT       FF              II       LL         EE            SS
   DD      DD   OO      OO      TT       FFFFFFFFF       II       LL         EEEEEEEEEE       SS
  DD      DD   OO      OO      TT       FF              II       LL         EE                 SS
 DDDDDDDDD      OOOOOOO       TT       FF          IIIIIIIIIII  LLLLLLLLL  EEEEEEEEEE    SSSSSSS

####################################################################################################

EOS
}

install-go-with-apt() {
  log-info "Installing golang ..."
  sudo add-apt-repository -y ppa:longsleep/golang-backports
	sudo apt -yqq update
  do-install sudo apt install -yqq golang-go
}

verify-system() {
  if ! check-command "go" && check-command 'apt'
  then
		install-go-with-apt
  fi

  local required_commands=('git' 'zsh' 'go')
  local valid=true
  for cmd in ${required_commands[@]}
  do
    if ! check-command "$cmd"
    then
      log-error "Cannot found $cmd"
      valid=false
    fi
  done
  if $valid
  then
    log-success "Complete system verification."
  else
    exit(1)
  fi
}

do-install() {
  local name="$1"
  shift
  if $@
  then
    log-success "Installed $name"
  else
    log-error "Failed to install $name"
  fi
}

show-welcome-message
verify-system


packages() {
  name=$1
  filename="./packages/$name.txt"
  echo $(cat $filename | tr '\n' ' ')
}

apt_packages=($(packages 'apt'))
go_packages=($(packages 'go'))

install-packages() {
  echo $@
  command="${@:1:($# - 1)}"
  packages=${@:$#:1}
  for pkg in ${packages[@]}
  do
    echo $command $pkg
    do-install "$pkg" $command "$pkg"
  done
}

if check-command 'apt'
then
  sudo apt update -yqq
 else
  log-warning "apt not found. Skip install apt packages"
fi

install-packages go get "$go_packages"
for pkg in ${go_packages[@]}
do
  do-install "$pkg" go get "$pkg"
done

zsh "scripts/install-symlinks.zsh"
