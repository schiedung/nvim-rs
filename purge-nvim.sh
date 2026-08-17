#!/bin/bash
echo "This will delete all Neovim configuration AND plugin data:"
echo "  ~/.config/nvim        (config, plus the SVN diff/merge wrappers)"
echo "  ~/.local/share/nvim   (lazy.nvim plugins, mason packages)"
echo "  ~/.local/state/nvim   (swap, undo, shada)"
echo "  ~/.cache/nvim"
echo
echo "NOTE: if you registered the SVN wrappers in ~/.subversion/config, those"
echo "paths will dangle afterwards and 'svn diff' will break until you update it."
echo
read -p "Are you sure you want to delete all Neovim configuration files (y/n)? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
    rm -rf ~/.cache/nvim
    echo "Neovim configuration and plugin data removed."
fi
