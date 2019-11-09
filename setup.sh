#!/bin/bash

DOT_FILES=(.bashrc .vimrc .vim .latexmkrc .config)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
