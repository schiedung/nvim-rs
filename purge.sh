#!/bin/bash
echo "This will delete all Vim AND Neovim configuration and plugin data:"
echo "  ~/.vimrc, ~/.vim       (Vim config and Vundle plugins)"
echo "  ~/.config/nvim         (config, plus the SVN diff/merge wrappers)"
echo "  ~/.local/share/nvim    (lazy.nvim plugins, mason packages)"
echo "  ~/.local/state/nvim    (swap, undo, shada)"
echo "  ~/.cache/nvim"
echo
echo "NOTE: if you registered the SVN wrappers in ~/.subversion/config, those"
echo "paths will dangle afterwards and 'svn diff' will break until you update it."
echo
read -p "Are you sure you want to delete all Vim and Neovim configuration files (y/n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -f ~/.vimrc
    rm -rf ~/.vim
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
    rm -rf ~/.cache/nvim
    echo "Vim and Neovim configuration and plugin data removed."
fi
