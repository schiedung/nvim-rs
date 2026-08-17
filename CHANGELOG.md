# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased] - 2026-08-17

**Requires Neovim 0.11 or newer.** `init.lua` uses `vim.lsp.enable` and
`vim.diagnostic.jump`, neither of which exists on 0.9/0.10.

### Removed
- Removed `nvim/init.vim`; the Vundle-based Neovim configuration is no longer supported.
  `init.lua` is now the only Neovim configuration. `install.sh` no longer symlinks it,
  clones Vundle into `~/.config/nvim`, or runs `nvim +VundleInstall` — it still installs
  the Vim configuration, the SVN helper scripts, the Nerd Font and `git core.editor`.
  The plain-Vim config (`vim/vimrc`) is unaffected.
- Removed the disabled `mason-lspconfig.nvim` block from `init.lua`. It could not have
  worked if re-enabled: `setup_handlers` no longer exists in mason-lspconfig 2.x, and it
  used the removed `require("lspconfig")[server].setup{}` framework, which contradicts
  the `vim.lsp.enable` wiring. `:Mason` plus `vim.lsp.enable` cover its purpose.
- Removed the disabled `nvim-cmp` block from `init.lua`. It was structurally invalid, not
  merely disabled: the `cmp.setup.cmdline(...)` and `lspconfig` calls were positional
  array elements of the table passed to `cmp.setup{}`, and it listed itself as a
  dependency.
- Removed the disabled `gruvbox.nvim` block from `init.lua`. It had no `priority`, so
  re-enabling it as written would have overridden kanagawa rather than replaced it.
- Removed the dead `<F3>` YouCompleteMe mapping from `vim/vimrc` (the plugin is not in
  its plugin list).

### Fixed
- Wired up LSP in `init.lua`: `nvim-lspconfig` now calls
  `vim.lsp.enable({ "clangd", "lua_ls" })` and an `LspAttach` autocmd applies the
  previously unreachable `on_attach` keybindings
- Replaced deprecated `vim.diagnostic.goto_prev`/`goto_next` (`[d`/`]d`) with
  `vim.diagnostic.jump`, which is deprecated as of Neovim 0.13
- Dropped `gr`, `K`, `<space>rn` and `<space>ca` from the LSP `on_attach`: Neovim 0.11+
  provides `grr`, `K`, `grn` and `gra` by default, and mapping bare `gr` made every
  `gr` press wait out `timeoutlen` before firing
- `gp.nvim` never loaded — `lazy = true` with no trigger meant `setup()` never ran and no
  `:Gp*` command existed. It now loads on its commands and on `VeryLazy`
- `indent-blankline.nvim` never loaded, for the same reason; it now loads on
  `BufReadPost`/`BufNewFile`
- Pinned `nvim-treesitter` to `branch = "master"`. This config uses the classic
  `nvim-treesitter.configs` API, which does not exist on `main`; without the pin, a fresh
  clone would break once upstream makes `main` the default
- Removed `fold = { enable = true }` from the treesitter config — there is no `fold`
  module, so the key was silently discarded. Folding comes from the `foldmethod`/
  `foldexpr`/`foldlevel` options set alongside it
- Removed `checker.auto_install`, which is not a valid lazy.nvim option
- `purge.sh` and `purge-nvim.sh` now remove `~/.local/share/nvim`, `~/.local/state/nvim`
  and `~/.cache/nvim`. Previously a "purge" left every installed plugin behind
- All three `.bat` scripts now use `%LOCALAPPDATA%`/`%USERPROFILE%` instead of
  `%HOMEPATH%`, which has no drive letter and so resolved against the current drive
- `purge.bat` and `purge-nvim.bat` now prompt for confirmation, matching the shell
  scripts; `purge.bat` targets `~\vimfiles` rather than the nonexistent `~\vim`
- `install.sh` no longer aborts the entire Neovim setup when `vim +VundleInstall` fails
- Both installers resolve paths from the script's own location instead of `${PWD}`, so
  running them from another directory no longer creates broken symlinks
- The `install.sh` font download runs in a subshell, so its `cd` cannot leak
- Quoted the path arguments in `nvim/svndiff.sh` and `nvim/svnmerger.sh` so filenames
  containing spaces work
- Fixed `purge.bat` using `DEL` on directories; now uses `RMDIR /S /Q` and also removes
  `nvim-data`
- Fixed typo in `purge.sh`: "delte" → "delete" (previously credited to `purge-nvim.sh`,
  which never contained it)
- Fixed dead fugitive bindings in `vim/vimrc`: `:Gstatus` → `:Git status` and
  `:Gcommit` → `:Git commit`, both removed from fugitive; `:Gdiff` → `:Gdiffsplit`
- Spelled `:Gvdiffsplit` in full in `init.lua` (`:Gvdiff` works only as an abbreviation)
- Removed the duplicate `hardtime_default_on` in `vim/vimrc`
- Fixed typo in `vim/vimrc` comment: "majutsuxhi" → "majutsushi"
- Fixed deprecated `vim.lsp.diagnostic` API calls to `vim.diagnostic` in `init.lua`
- Fixed the gp.nvim agent name typo: "Joda" → "Yoda"
- `ctags` is invoked from `PATH` rather than a hardcoded `/usr/bin/ctags`

### Added
- Added error handling to installation scripts
- Made installation scripts idempotent (safe to run multiple times)
- Added checks for existing symlinks before creating new ones
- Added informative messages to installation scripts
- Added comprehensive README.md documentation
- Added plugin functionality descriptions
- Added key bindings documentation
- Added troubleshooting section
- Added CHANGELOG.md to track project changes

### Changed
- Standardised `init.lua` keymaps on `vim.keymap.set` with `desc`, so which-key shows
  labels instead of unnamed entries
- Lazy-loaded telescope on its keys and `:Telescope`; tagbar on `<F8>` and its commands.
  `vim-fugitive` is deliberately left eager, since it provides far more than the five
  keys mapped to it
- Documented how to register the SVN diff/merge wrappers in `~/.subversion/config`;
  `install.sh` prints the snippet, and both purge scripts warn that removing
  `~/.config/nvim` breaks that registration
- Disabled lazy.nvim's luarocks support (`rocks = { enabled = false }`), which no plugin
  here needs and which reported an error in `:checkhealth`
- Updated `.editorconfig` to use 4-space indentation (matching actual code style)
- Cleaned up commented-out code in `init.lua`
- Simplified plugin configuration sections
- Improved code organization and readability

### Documentation
- Comprehensive rewrite of README.md with:
  - Project description
  - Installation instructions for both configurations
  - Plugin lists with descriptions
  - Complete key bindings reference
  - Feature comparisons
  - Troubleshooting guide
  - Contributing guidelines

## Notes

This repository contains:
1. **nvim/init.lua** - the Neovim configuration (lazy.nvim)
2. **vim/vimrc** - a legacy configuration for plain Vim (Vundle)

The Vundle-based Neovim configuration (`nvim/init.vim`) was removed; see the Removed
section above.
