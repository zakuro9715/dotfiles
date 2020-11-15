zsh "scripts/install-symlinks.zsh"
basedir=$(cd $(dirname $0); pwd)
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

packages() {
  name=$1
  filename="./packages/$name.txt"
  echo $(cat $filename | tr '\n' ' ')
}


source "$HOME/.zshrc"
for script in $(ls $basedir/installers/* | cat)
do
  echo $script
  $script "$basedir"
done
