#!/bin/bash

mkdir -p ~/dotfiles/.vim/dein
cd ~/dotfiles/.vim/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/dotfiles/.vim/dein
cd ~/dotfiles

DOT_FILES=(.vimrc .vim .latexmkrc .config)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

curl -# -O -L https://github.com/miiton/Cica/releases/download/v5.0.1/Cica_v5.0.1_with_emoji.zip
unzip Cica_v5.0.1_with_emoji.zip
sudo mkdir -p /usr/local/share/fonts
sudo cp *.ttf /usr/local/share/fonts/
cd ~/dotfiles
rm *.ttf 
rm Cica_v5.0.1_with_emoji.zip
sudo fc-cache -vf
fc-list | grep Cica
