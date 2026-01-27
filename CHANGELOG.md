# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased] - 2026-01-25

### Fixed
- Fixed typo in `purge-nvim.sh`: "delte" → "delete"
- Fixed symlink error in `install.sh`: `svnmerger.sh.vim` → `svnmerger.sh`
- Fixed duplicate `hardtime_default_on` setting in `init.vim`
- Fixed typo in `init.vim` comment: "majutsuxhi" → "majutsushi"
- Fixed deprecated `vim.lsp.diagnostic` API calls to `vim.diagnostic` in `init.lua`
- Fixed typos in `init.lua`: "Joda" → "Yoda", "aswering" → "answering"

### Added
- Enabled `mapleader` configuration in `init.lua` (set to Space key)
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
- Updated `.editorconfig` to use 4-space indentation (matching actual code style)
- Cleaned up commented-out code in `init.vim`
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

This repository contains two different Neovim configurations:
1. **init.vim** - Traditional Vundle-based configuration
2. **init.lua** - Modern lazy.nvim-based configuration

Choose the one that best fits your workflow!
