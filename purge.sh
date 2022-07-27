#!/bin/bash
read -p "Are you sure to delte all vim and neovim configuration files (y/n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm ~/.vimrc
    rm -rf ~/.vim
    rm -rf ~/.config/nvim
fi

