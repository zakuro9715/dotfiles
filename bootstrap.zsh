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
	sudo apt update
	sudo apt install -y golang-go
  log-success "Complete"
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

required_go_packages=(
  "github.com/github/hub"
  "github.com/x-motemen/ghq"
)

required_repositories=(
  "zsh-users/zsh-completions"
)

show-welcome-message
verify-system

export GOPATH="$HOME"
for pkg in ${required_go_packages[@]}
do
  do-install "$pkg" go get "$pkg"
done

export PATH="$GOPATH/bin:$PATH"
for repo in ${required_repositories[@]}
do
  do-install "$repo" ghq get "$repo"
done

zsh "scripts/install-symlinks.zsh"
