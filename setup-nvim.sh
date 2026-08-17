#!/bin/bash
set -e  # Exit on error

# Resolve the repo root from the script's own location, so the symlink below
# points at a real file no matter which directory this is invoked from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -x "$(command -v nvim)" ];
then
    echo "Setting up Neovim configuration (Lua-based)..."
    mkdir -p ~/.config/nvim

    # Remove existing symlink if it exists.
    # NOTE: not redundant with `ln -sf` — if the target is a symlink to a
    # directory, `ln -sf` links *into* it rather than replacing it.
    [ -L ~/.config/nvim/init.lua ] && rm ~/.config/nvim/init.lua

    ln -sf "${SCRIPT_DIR}/nvim/init.lua" ~/.config/nvim/init.lua
    echo "Neovim Lua configuration installed successfully."
    echo "Note: This uses lazy.nvim plugin manager. Plugins will be installed on first launch."
    echo "Requires Neovim 0.11 or newer (uses vim.lsp.enable and vim.diagnostic.jump)."
else
    echo "Neovim not found. Please install Neovim first."
    exit 1
fi
