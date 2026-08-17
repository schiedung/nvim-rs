#!/bin/bash
set -e  # Exit on error

# Resolve the repo root from the script's own location, so the symlinks below
# point at real files no matter which directory this is invoked from.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing Vim configuration and Neovim helper scripts..."

if [ -x "$(command -v vim)" ];
then
    echo "Setting up Vim configuration..."
    mkdir -p ~/.vim

    # Remove existing symlink if it exists.
    # NOTE: this guard is not redundant with `ln -sf`. If the target is a symlink
    # to a directory, `ln -sf` creates the new link *inside* that directory
    # instead of replacing it.
    [ -L ~/.vimrc ] && rm ~/.vimrc

    ln -sf "${SCRIPT_DIR}/vim/vimrc" ~/.vimrc

    # Install Vundle if not already installed
    if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi

    # Do not let a Vundle failure abort the rest of the script under `set -e`;
    # the Neovim setup below is independent of it.
    vim +VundleInstall +qall || echo "warning: VundleInstall failed, continuing"
    git config --global core.editor "vim"
    echo "Vim configuration installed successfully."
else
    echo "Vim not found, skipping Vim configuration."
fi

if [ -x "$(command -v nvim)" ];
then
    # NOTE: the Neovim config itself (init.lua) is installed by setup-nvim.sh.
    # This branch only installs the Neovim helper scripts, font and git editor.
    echo "Setting up Neovim helper scripts..."
    # Creates ~/.config/nvim, which the symlinks below depend on.
    mkdir -p ~/.config/nvim

    # Remove existing symlinks if they exist (see the note above about ln -sf)
    [ -L ~/.config/nvim/svndiff.sh ] && rm ~/.config/nvim/svndiff.sh
    [ -L ~/.config/nvim/svnmerger.sh ] && rm ~/.config/nvim/svnmerger.sh

    ln -sf "${SCRIPT_DIR}/nvim/svndiff.sh" ~/.config/nvim/svndiff.sh
    ln -sf "${SCRIPT_DIR}/nvim/svnmerger.sh" ~/.config/nvim/svnmerger.sh

    git config --global core.editor "nvim"

    # Install Nerd Fonts. The cd runs in a subshell so it cannot leak into the
    # rest of the script.
    mkdir -p ~/.local/share/fonts
    if [ ! -f ~/.local/share/fonts/DroidSansMNerdFont-Regular.otf ]; then
        echo "Downloading Nerd Fonts..."
        (
            cd ~/.local/share/fonts \
                && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
        ) || echo "warning: font download failed, continuing"
        fc-cache -fv 2>/dev/null || true
    fi

    echo "Neovim helper scripts installed successfully."
    echo "Run ./setup-nvim.sh to install the Neovim config (init.lua)."
    echo
    echo "To use the SVN diff/merge wrappers, add this to ~/.subversion/config:"
    echo "  [helpers]"
    echo "  diff-cmd = ${HOME}/.config/nvim/svndiff.sh"
    echo "  merge-tool-cmd = ${HOME}/.config/nvim/svnmerger.sh"
else
    echo "Neovim not found, skipping Neovim setup."
fi

echo "Installation complete!"
