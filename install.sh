#!/bin/bash
set -e  # Exit on error

echo "Installing Vim and Neovim configurations..."

if [ -x "$(command -v vim)" ];
then
    echo "Setting up Vim configuration..."
    mkdir -p ~/.vim
    
    # Remove existing symlink if it exists
    [ -L ~/.vimrc ] && rm ~/.vimrc
    
    ln -sf "${PWD}/vim/vimrc" ~/.vimrc
    
    # Install Vundle if not already installed
    if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
    
    vim +VundleInstall +qall
    git config --global core.editor "vim"
    echo "Vim configuration installed successfully."
else
    echo "Vim not found, skipping Vim configuration."
fi

if [ -x "$(command -v nvim)" ];
then
    echo "Setting up Neovim configuration..."
    mkdir -p ~/.config/nvim/tmp
    
    # Remove existing symlinks if they exist
    [ -L ~/.config/nvim/init.vim ] && rm ~/.config/nvim/init.vim
    [ -L ~/.config/nvim/svndiff.sh ] && rm ~/.config/nvim/svndiff.sh
    [ -L ~/.config/nvim/svnmerger.sh ] && rm ~/.config/nvim/svnmerger.sh
    
    ln -sf "${PWD}/nvim/init.vim" ~/.config/nvim/init.vim
    ln -sf "${PWD}/nvim/svndiff.sh" ~/.config/nvim/svndiff.sh
    ln -sf "${PWD}/nvim/svnmerger.sh" ~/.config/nvim/svnmerger.sh
    
    # Install Vundle if not already installed
    if [ ! -d ~/.config/nvim/bundle/Vundle.vim ]; then
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
    fi
    
    nvim +VundleInstall +qall
    git config --global core.editor "nvim"
    
    # Install Nerd Fonts
    mkdir -p ~/.local/share/fonts
    if [ ! -f ~/.local/share/fonts/DroidSansMNerdFont-Regular.otf ]; then
        echo "Downloading Nerd Fonts..."
        cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
        fc-cache -fv 2>/dev/null || true
    fi
    
    echo "Neovim configuration installed successfully."
else
    echo "Neovim not found, skipping Neovim configuration."
fi

echo "Installation complete!"
