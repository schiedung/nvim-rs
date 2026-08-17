# NVIM config

## Description

This repository contains personal Neovim and Vim configuration files:

1. **nvim/init.lua** (lazy.nvim-based): the Neovim configuration
2. **vim/vimrc** (Vundle-based): a legacy configuration for plain Vim

The configurations are optimized for C/C++/CUDA development with support for various other languages.

> **Note**: the Vundle-based Neovim configuration (`nvim/init.vim`) has been removed and
> is no longer supported. `init.lua` is the only Neovim configuration.

## Pre-requisites

### Linux

```bash
sudo apt-get install -y neovim git
```

**Neovim 0.11 or newer is required** — `init.lua` uses `vim.lsp.enable` and
`vim.diagnostic.jump`, which do not exist on 0.9/0.10. Note that `apt-get install neovim`
ships an older release on Debian/Ubuntu; use the AppImage, the unstable PPA, or a
release tarball if your distribution lags behind.

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

### Neovim (init.lua with lazy.nvim)

This installs the Neovim configuration.

#### Linux

```bash
./setup-nvim.sh
```

#### Windows

```bash
./setup-nvim.bat
```

**Note**: Plugins are installed automatically on the first launch of Neovim.

### Vim (legacy, Vundle)

`install.sh` installs the plain-Vim configuration (`vim/vimrc`) with Vundle. It also
installs the Neovim helper scripts (SVN diff/merge wrappers), the Nerd Font, and sets
`git core.editor` — but it does **not** install a Neovim configuration; use
`setup-nvim.sh` for that.

```bash
./install.sh
```

There is currently no Windows equivalent of `install.sh`.

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

### Plugins in vim/vimrc (Vundle-based, legacy Vim)

| Plugin                                                                                  | Functionality                                            |
| --------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| [Chiel92/vim-autoformat](https://github.com/Chiel92/vim-autoformat)                     | Auto-format code using external formatters               |
| [altercation/vim-colors-solarized](https://github.com/altercation/vim-colors-solarized) | Solarized color scheme                                   |
| [github/copilot.vim](https://github.com/github/copilot.vim)                             | GitHub Copilot AI pair programmer                        |
| [godlygeek/tabular](https://github.com/godlygeek/tabular)                               | Text alignment and formatting                            |
| [kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)                                     | Fuzzy file finder                                        |
| [majutsushi/tagbar](https://github.com/majutsushi/tagbar)                               | Display tags in a window, ordered by scope               |
| [morhetz/gruvbox](https://github.com/morhetz/gruvbox)                                   | Gruvbox color scheme                                     |
| [petRUShka/vim-sage](https://github.com/petRUShka/vim-sage)                             | SageMath syntax support                                  |
| [rhysd/vim-clang-format](https://github.com/rhysd/vim-clang-format)                     | Clang-format integration                                 |
| [rickhowe/diffchar.vim](https://github.com/rickhowe/diffchar.vim)                       | Character-level diff highlighting                        |
| [scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)                           | File system explorer                                     |
| [scrooloose/syntastic](https://github.com/scrooloose/syntastic)                         | Syntax checking                                          |
| [takac/vim-hardtime](https://github.com/takac/vim-hardtime)                             | Break bad Vim habits by discouraging repeated keys       |
| [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)                             | Git wrapper for Vim                                      |
| [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)                   | Lean & mean status/tabline                               |

### Plugins in init.lua (lazy.nvim-based, Neovim)

| Plugin                                                                                  | Functionality                                            |
| --------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)                       | Kanagawa color scheme                                    |
| [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)           | Modern file explorer                                     |
| [github/copilot.vim](https://github.com/github/copilot.vim)                             | GitHub Copilot AI pair programmer                        |
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

### Common to both configurations

- `<F4>` - Generate ctags for current directory
- `<F8>` - Toggle Tagbar
- `<C-n>` - Toggle file tree (NERDTree in Vim / Neo-tree in Neovim)
- `<leader>gw` - Git write (stage current file)
- `<leader>gr` - Git read (checkout current file)
- `<leader>gs` - Git status
- `<leader>gd` - Git diff
- `<leader>gc` - Git commit

### Vim (vim/vimrc) only

- `<F2>` - Remove trailing whitespace and retab

### Neovim (init.lua) only

**Note**: `<leader>` is the default backslash (`\`) — `mapleader` is not reassigned, so
`<leader>ff` means `\ff`.

- `<leader>ff` - Telescope find files
- `<leader>fg` - Telescope live grep
- `<leader>fb` - Telescope buffers
- `<leader>fh` - Telescope help tags
- `<leader>n` - Toggle Neo-tree
- `<leader>ln` - Toggle relative line numbers
- `<leader>?` - Show buffer-local keymaps (which-key)
- `<Esc>` - Leave terminal mode

LSP bindings added by this config when a language server attaches:

- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `<C-k>` - Signature help
- `[d` / `]d` - Previous / next diagnostic
- `<space>e` - Show diagnostic in a float
- `<space>q` - Diagnostics to location list

Rename, code actions and references are **not** remapped here — Neovim 0.11+ provides
them out of the box, and redefining them only added a keystroke delay:

- `grn` - Rename symbol (built-in)
- `gra` - Code actions (built-in)
- `grr` - Go to references (built-in)
- `gri` - Go to implementation (built-in)
- `K` - Show hover documentation (built-in)

## Features

### Both configurations

- Line numbers enabled
- 80-column ruler
- Spell checking enabled
- Smart indentation (4 spaces)
- Syntax highlighting
- Git integration (vim-fugitive)

### init.lua Specific Features

- Modern Lua-based configuration
- LSP support (clangd, lua_ls) via `vim.lsp.enable`
- Treesitter syntax highlighting and folding
- Telescope fuzzy finder
- ChatGPT/Ollama integration for AI assistance
- Lazy loading for the plugins that support it (neo-tree, telescope, tagbar, vimtex,
  gp.nvim, indent-blankline); colorscheme, treesitter, LSP and statusline load eagerly

### Vim (vim/vimrc) only

- CUDA filetype detection for `*.cu` / `*.cuh` (Neovim detects these itself)
- Syntastic syntax checking

### SVN integration (shipped by `install.sh`, not part of either config)

`nvim/svndiff.sh` and `nvim/svnmerger.sh` open SVN diffs and merges in Neovim.
`install.sh` symlinks them into `~/.config/nvim/`, but SVN does not look there — you must
register them yourself in `~/.subversion/config`:

```ini
[helpers]
diff-cmd = /home/<user>/.config/nvim/svndiff.sh
merge-tool-cmd = /home/<user>/.config/nvim/svnmerger.sh
```

**Note**: `purge.sh` / `purge-nvim.sh` delete `~/.config/nvim`, which removes these
wrappers and leaves those paths dangling.

## Troubleshooting

### Plugins not loading

**Neovim (init.lua)**: Restart Neovim; lazy.nvim auto-installs on first launch. Use
`:Lazy` to inspect plugin state.

**Vim (vimrc)**: Run `:PluginInstall` inside Vim

### Nerd Fonts not displaying correctly (Linux)

1. Ensure font cache is updated: `fc-cache -fv`
2. Set your terminal to use the installed Nerd Font
3. The font is downloaded by `install.sh`

On Windows there is no font installer — download a Nerd Font manually and set it in your
terminal. The SVN wrappers are shell scripts and are Linux/macOS only.

### LSP not working (init.lua)

1. Ensure clangd is installed: `sudo apt-get install clangd`
2. For other languages, use `:Mason` to install language servers, then add the server
   name to the `vim.lsp.enable({ ... })` call in `nvim/init.lua`
3. Check that a server attached with `:checkhealth vim.lsp`

## Contributing

Feel free to fork this repository and customize it for your needs. Pull requests for improvements are welcome!

## License

See LICENSE file for details.
