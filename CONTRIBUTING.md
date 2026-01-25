# Contributing to nvim-rs

Thank you for considering contributing to this Neovim/Vim configuration repository!

## How to Contribute

### Reporting Issues

If you encounter any problems or have suggestions for improvements:

1. Check if the issue already exists in the GitHub Issues
2. Provide clear steps to reproduce the issue
3. Include your environment details (OS, Neovim/Vim version)
4. Mention which configuration you're using (init.vim or init.lua)

### Submitting Changes

1. Fork the repository
2. Create a new branch for your feature/fix: `git checkout -b feature/your-feature-name`
3. Make your changes following the guidelines below
4. Test your changes thoroughly
5. Commit your changes with clear, descriptive messages
6. Push to your fork and submit a pull request

## Code Style Guidelines

### General

- Use 4 spaces for indentation (as configured in `.editorconfig`)
- Keep lines under 80 characters when practical
- Remove trailing whitespace
- Add comments for complex configurations

### VimScript (init.vim)

- Group related settings together
- Use clear section headers with comment blocks
- Follow existing naming conventions
- Document any non-obvious keybindings

### Lua (init.lua)

- Follow standard Lua formatting conventions
- Use descriptive variable names
- Add comments for plugin configurations
- Keep plugin specifications organized

## Plugin Guidelines

### Adding New Plugins

When adding a new plugin:

1. **Research**: Ensure the plugin is actively maintained
2. **Compatibility**: Test with both Neovim versions (0.9+)
3. **Documentation**: Add the plugin to README.md with description
4. **Configuration**: Add necessary configuration with comments
5. **Performance**: Consider lazy loading when appropriate

### For init.vim (Vundle)

```vim
" Add to the plugin list
Plugin 'username/plugin-name'

" Add configuration in the appropriate section
" Plugin-name settings
let g:plugin_setting = value
```

### For init.lua (lazy.nvim)

```lua
{ "username/plugin-name",
  lazy = true, -- lazy load if appropriate
  config = function()
    -- Plugin configuration here
  end,
},
```

## Testing

Before submitting a pull request:

1. **Test Installation**: Run installation scripts in a clean environment
2. **Test Configurations**: 
   - For init.vim: `nvim +PluginInstall +qall` should complete without errors
   - For init.lua: Launch nvim and ensure lazy.nvim installs plugins correctly
3. **Test Functionality**: Verify all keybindings and features work
4. **Check for Errors**: Run `:checkhealth` in Neovim

## Commit Message Guidelines

Write clear and descriptive commit messages:

```
Short summary (50 chars or less)

More detailed explanation if needed. Wrap at 72 characters.

- Use bullet points for multiple changes
- Reference issues with #issue-number
- Keep each commit focused on a single change
```

Examples:
- `Add telescope.nvim for fuzzy finding`
- `Fix LSP keybindings for diagnostics`
- `Update README with installation troubleshooting`

## Documentation

When making changes:

1. Update README.md if adding features or changing installation
2. Update CHANGELOG.md with your changes
3. Add comments to code for complex configurations
4. Update keybinding documentation if applicable

## Areas That Need Help

Current areas where contributions are especially welcome:

- [ ] Testing mason-lspconfig integration with newer versions
- [ ] Testing nvim-cmp integration
- [ ] Additional language server configurations
- [ ] Windows-specific installation improvements
- [ ] macOS installation scripts and documentation
- [ ] Additional theme options
- [ ] Performance optimizations

## Questions?

Feel free to open an issue with the `question` label if you have any questions about contributing!

## Code of Conduct

Be respectful and constructive in all interactions. This is a personal configuration repository shared with the community to help others.

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (see LICENSE file).
