#!/bin/bash
if [ -x "$(command -v vim)" ];
then
    mkdir -p ~/.vim
    ln -s ${PWD}/vim/vimrc ~/.vimrc
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim  +VundleInstall +qall
    git config --global core.editor "vim"
fi

if [ -x "$(command -v nvim)" ];
then
    mkdir -p ~/.config/nvim/tmp
    ln -s ${PWD}/nvim/init.vim ~/.config/nvim/init.vim
    ln -s ${PWD}/nvim/svndiff.sh ~/.config/nvim/svndiff.sh
    ln -s ${PWD}/nvim/svnmerger.sh ~/.config/nvim/svnmerger.sh.vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
    nvim +VundleInstall +qall
    git config --global core.editor "nvim"
fi
