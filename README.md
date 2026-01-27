# NVIM config

## Description

This repository contains personal Neovim and Vim configuration files. It provides two different Neovim configurations:

1. **init.vim** (Vundle-based): Traditional Vim configuration using Vundle plugin manager
2. **init.lua** (Lazy.nvim-based): Modern Lua-based configuration using lazy.nvim plugin manager

The configurations are optimized for C/C++/CUDA development with support for various other languages.

## Pre-requisites

### Linux

```bash
sudo apt-get install -y neovim git luarocks
```

For full functionality, also install:
```bash
# For C/C++ development
sudo apt-get install -y clang clangd ctags

# For font support
sudo apt-get install -y fontconfig
```

## Installation

Neovim and Vim configuration files will be installed if Neovim or Vim is
installed on the system. The configuration files will be installed in the user's
home directory.

### Option 1: Complete Installation (Vim + Neovim with init.vim)

This installs both Vim and Neovim configurations using the traditional Vundle plugin manager.

#### Linux

```bash
./install.sh
```

#### Windows

```bash
./install.bat
```

### Option 2: Modern Neovim Setup (init.lua with lazy.nvim)

This installs only the modern Lua-based Neovim configuration with lazy.nvim.

#### Linux

```bash
./setup-nvim.sh
```

#### Windows

```bash
./setup-nvim.bat
```

**Note**: When using init.lua, plugins will be automatically installed on the first launch of Neovim.

## Uninstallation

To remove Neovim configuration:

```bash
./purge-nvim.sh  # Linux
./purge-nvim.bat # Windows
```

To remove all Vim and Neovim configurations:

```bash
./purge.sh  # Linux
./purge.bat # Windows
```

## Plugins

### Plugins in init.vim (Vundle-based)

| Plugin                                                                                  | Functionality                                            |
| --------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| [Chiel92/vim-autoformat](https://github.com/Chiel92/vim-autoformat)                     | Auto-format code using external formatters               |
| [altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized) | Solarized color scheme                                   |
| [github/copilot.vim](https://github.com/github/copilot.vim)                             | GitHub Copilot AI pair programmer                        |
| [godlygeek/tabular](https://github.com/godlygeek/tabular)                               | Text alignment and formatting                            |
| [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)         | Preview markdown files in browser                        |
| [kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)                                     | Fuzzy file finder                                        |
| [majutsushi/tagbar](https://github.com/majutsushi/tagbar)                               | Display tags in a window, ordered by scope               |
| [morhetz/gruvbox](https://github.com/morhetz/gruvbox)                                   | Gruvbox color scheme                                     |
| [petRUShka/vim-sage](https://github.com/petRUShka/vim-sage)                             | SageMath syntax support                                  |
| [psliwka/vim-smoothie](https://github.com/psliwka/vim-smoothie)                         | Smooth scrolling for Ctrl-D and Ctrl-U                   |
| [rhysd/vim-clang-format](https://github.com/rhysd/vim-clang-format)                     | Clang-format integration                                 |
| [rickhowe/diffchar.vim](https://github.com/rickhowe/diffchar.vim)                       | Character-level diff highlighting                        |
| [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons)                     | File type icons                                          |
| [scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)                           | File system explorer                                     |
| [scrooloose/syntastic](https://github.com/scrooloose/syntastic)                         | Syntax checking                                          |
| [takac/vim-hardtime](https://github.com/takac/vim-hardtime)                             | Break bad Vim habits by discouraging repeated keys       |
| [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)                             | Git wrapper for Vim                                      |
| [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)                   | Lean & mean status/tabline                               |

### Plugins in init.lua (lazy.nvim-based)

| Plugin                                                                                  | Functionality                                            |
| --------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)                       | Kanagawa color scheme (default)                          |
| [ellisonleao/gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)                 | Gruvbox color scheme (alternative)                       |
| [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)           | Modern file explorer                                     |
| [robitx/gp.nvim](https://github.com/robitx/gp.nvim)                                     | ChatGPT/Ollama integration                               |
| [godlygeek/tabular](https://github.com/godlygeek/tabular)                               | Text alignment and formatting                            |
| [m4xshen/hardtime.nvim](https://github.com/m4xshen/hardtime.nvim)                       | Modern hardtime plugin                                   |
| [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)                             | Git wrapper for Neovim                                   |
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)   | Advanced syntax highlighting and code understanding      |
| [lervag/vimtex](https://github.com/lervag/vimtex)                                       | LaTeX support                                            |
| [majutsushi/tagbar](https://github.com/majutsushi/tagbar)                               | Display tags in a window                                 |
| [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)                   | Status line                                              |
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                       | LSP configuration                                        |
| [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)                   | LSP/DAP/linter/formatter package manager                 |
| [karb94/neoscroll.nvim](https://github.com/karb94/neoscroll.nvim)                       | Smooth scrolling                                         |
| [folke/which-key.nvim](https://github.com/folke/which-key.nvim)                         | Display available keybindings                            |
| [lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Indentation guides                          |
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)       | Fuzzy finder                                             |

## Key Bindings

### Common Bindings (Both Configurations)

- `<F2>` - Remove trailing whitespace and retab
- `<F4>` - Generate ctags for current directory
- `<F8>` - Toggle Tagbar
- `<C-n>` - Toggle file tree (NERDTree/Neo-tree)
- `<leader>gw` - Git write (stage current file)
- `<leader>gr` - Git read (checkout current file)
- `<leader>gs` - Git status
- `<leader>gd` - Git diff
- `<leader>gc` - Git commit

### init.lua Specific Bindings

- `<leader>` - Space key (leader key)
- `<leader>ff` - Telescope find files
- `<leader>fg` - Telescope live grep
- `<leader>fb` - Telescope buffers
- `<leader>fh` - Telescope help tags
- `<leader>n` - Toggle Neo-tree
- `gd` - Go to definition (LSP)
- `gr` - Go to references (LSP)
- `K` - Show hover documentation (LSP)
- `<space>rn` - Rename symbol (LSP)
- `<space>ca` - Code actions (LSP)

## Features

### Both Configurations

- Line numbers enabled
- 80-column ruler
- Spell checking enabled
- Smart indentation (4 spaces)
- Syntax highlighting
- Git integration (vim-fugitive)
- Support for CUDA files (*.cu, *.cuh)
- SVN diff and merge tool integration

### init.lua Specific Features

- Modern Lua-based configuration
- Lazy loading plugins for faster startup
- LSP support with clangd
- Treesitter syntax highlighting
- Telescope fuzzy finder
- ChatGPT/Ollama integration for AI assistance
- More modern plugin ecosystem

## Troubleshooting

### Plugins not loading

If plugins don't load:

**For init.vim**: Run `:PluginInstall` inside Vim/Neovim

**For init.lua**: Restart Neovim; lazy.nvim will auto-install on first launch

### Nerd Fonts not displaying correctly

1. Ensure font cache is updated: `fc-cache -fv`
2. Set your terminal to use the installed Nerd Font
3. For init.vim, the font is auto-downloaded during installation

### LSP not working (init.lua)

1. Ensure clangd is installed: `sudo apt-get install clangd`
2. For other languages, use `:Mason` to install language servers

### init.lua vs init.vim conflict

Neovim loads init.lua by default if both exist. To switch:
- Remove the unwanted config: `rm ~/.config/nvim/init.lua` or `rm ~/.config/nvim/init.vim`
- Or use different installation scripts

## Contributing

Feel free to fork this repository and customize it for your needs. Pull requests for improvements are welcome!

## License

See LICENSE file for details.
