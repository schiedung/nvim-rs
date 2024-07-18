-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
--vim.g.mapleader = " "
--vim.g.maplocalleader = "\\"

vim.opt.number = true -- Add line numbers
vim.opt.relativenumber = true  -- Set relative numbers
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line
vim.opt.autoindent = true -- Copy indent from current line when starting a new line
vim.opt.wrap = true -- Wrap lines
vim.opt.showbreak = "↪   " -- indicate line wrap
vim.opt.colorcolumn = "80" -- highlight column 80
vim.opt.spell = true -- Enable spell checking

--vim.api.nvim_create_autocmd("BufEnter", {
--  callback = function()
--    vim.lsp.start({
--      name = "clangd",
--      cmd = {"clangd"},
--      root_dir = vim.fn.getcwd(),
--    })
--  end,
--})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
      "rebelot/kanagawa.nvim", -- my custom colorscheme
      lazy = false, -- allways load this plugin
      priority = 1000, -- load this plugin before all others
      config = function()
        vim.cmd([[colorscheme kanagawa]])
      end,
    },
    {
      "ellisonleao/gruvbox.nvim", -- old colorscheme
      enabled = false,
      lazy = false,
      config = function()
        vim.cmd("colorscheme gruvbox")
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim", -- file tree plugin
      lazy = true, -- load this plugin lazily
      keys = { "<C-n>", "<leader>n", "<cmd>Neotree<CR>" }, -- key bindings to load plugin
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      },
      config = function()
        vim.api.nvim_set_keymap('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>n', ':Neotree toggle<CR>', { noremap = true, silent = true })
      end,
    },
    { "github/copilot.vim" },
    { "godlygeek/tabular"},
    { "m4xshen/hardtime.nvim",
       dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
       opts = { disable_mouse = false}
    },
    {
      "tpope/vim-fugitive", -- premier git plugin
      config = function()
        vim.api.nvim_set_keymap('n', '<leader>gw', ':Gwrite<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>gr', ':Gread<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>gs', ':Git status<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>gd', ':Gvdiff<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', { noremap = true, silent = true })
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter", -- syntax highlighting
      enabled = true,
      config = function()
        require'nvim-treesitter.configs'.setup {
          ensure_installed = {"lua", "c", "cpp", "cuda", "python", "bash", "markdown"},
          highlight = { enable = true, },
        }
      end,
    },
    {
      "lervag/vimtex",
      lazy = true,
      ft = "tex",
      init = function()
        -- VimTeX configuration goes here, e.g.
        -- vim.g.vimtex_view_method = "zathura"
      end,
    },
    {
      "majutsushi/tagbar",
      lazy = true,
      keys = { "<F4>", "<F8>" },
      config = function()
        vim.api.nvim_set_keymap('n', '<F4>', ':!/usr/bin/ctags -R --exclude=.git --exclude=documentation --c++-kinds=+p --langmap=c++:+.cu --fields=+liaS --extra=+q .<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true, silent = true })
      end,
    },
    { "vim-airline/vim-airline", },
    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")
        lspconfig.clangd.setup({})
      end,
    },
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
