#!/bin/bash

mkdir -p ~/dotfiles/.vim/dein
cd ~/dotfiles/.vim/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/dotfiles/.vim/dein
cd ~/dotfiles

DOT_FILES=(.vimrc .vim .latexmkrc)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
