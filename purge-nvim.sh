#!/bin/bash
read -p "Are you sure to delte all neovim configuration files (y/n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -rf ~/.config/nvim
fi

