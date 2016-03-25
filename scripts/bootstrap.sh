zsh install.zsh full
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zakuro9715/zakuroster.git ~/.oh-my-zsh/themes/zakuroster
git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
sh scripts/setup-vim-plugins.sh
