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

verify-system() {
  local required_commands=('git' 'zsh' 'ghq' 'go')
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


show-welcome-message
verify-system

zsh "scripts/install-symlinks.zsh"
git clone https://github.com/zakuro9715/zakuroster.git ~/.oh-my-zsh/themes/zakuroster
