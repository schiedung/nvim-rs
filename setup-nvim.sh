#!/bin/bash
set -e  # Exit on error

if [ -x "$(command -v nvim)" ];
then
    echo "Setting up Neovim configuration (Lua-based)..."
    mkdir -p ~/.config/nvim/tmp
    
    # Remove existing symlink if it exists
    [ -L ~/.config/nvim/init.lua ] && rm ~/.config/nvim/init.lua
    
    ln -sf "${PWD}/nvim/init.lua" ~/.config/nvim/init.lua
    echo "Neovim Lua configuration installed successfully."
    echo "Note: This uses lazy.nvim plugin manager. Plugins will be installed on first launch."
else
    echo "Neovim not found. Please install Neovim first."
    exit 1
fi
