cat << EOS

      DDDDDDDD      OOOOOOO   TTTTTTTTTTT   FFFFFFFFF  IIIIIIIIIII   LL         EEEEEEEEEE   SSSSSSS
     DD      DD   OO      OO      TT       FF              II       LL         EE          SS
    DD      DD   OO      OO      TT       FF              II       LL         EE            SS
   DD      DD   OO      OO      TT       FFFFFFFFF       II       LL         EEEEEEEEEE       SS
  DD      DD   OO      OO      TT       FF              II       LL         EE                 SS
 DDDDDDDDD      OOOOOOO       TT       FF          IIIIIIIIIII  LLLLLLLLL  EEEEEEEEEE    SSSSSSS

####################################################################################################
EOS


zsh "scripts/install-symlinks.zsh"

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zakuro9715/zakuroster.git ~/.oh-my-zsh/themes/zakuroster
git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
sh scripts/setup-vim-plugins.sh
