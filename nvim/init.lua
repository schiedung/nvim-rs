_G.vim = vim -- Make vim global so that it is available for lsp
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
-- Function to map keybindings
local function on_attach(_, bufnr)
  -- Create a local function to simplify mapping keybindings
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  -- Mappings.
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.frag", "*.vert"},
  callback = function()
    vim.bo.filetype = "glsl"
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.sage",
    callback = function()
        vim.bo.filetype = "python"
    end,
})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    { "rebelot/kanagawa.nvim", -- my custom colorscheme
      lazy = false, -- allways load this plugin
      priority = 1000, -- load this plugin before all others
      config = function()
        vim.cmd([[colorscheme kanagawa]])
      end,
    },
    { "ellisonleao/gruvbox.nvim", -- old colorscheme
      enabled = false,
      lazy = false,
      config = function()
        vim.cmd("colorscheme gruvbox")
      end,
    },
    { "nvim-neo-tree/neo-tree.nvim", -- file tree plugin
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
    {"tpope/vim-fugitive", -- premier git plugin
      config = function()
        vim.api.nvim_set_keymap('n', '<leader>gw', ':Gwrite<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>gr', ':Gread<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>gs', ':Git status<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>gd', ':Gvdiff<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', { noremap = true, silent = true })
      end,
    },
    { "nvim-treesitter/nvim-treesitter", -- syntax highlighting
      enabled = true,
      config = function()
        require'nvim-treesitter.configs'.setup {
          ensure_installed = {
            "lua",
            "vimdoc",
            "c",
            "cpp",
            "cuda",
            "python",
            "bash",
            "markdown",
            "yaml",
            "html"},
          highlight = { enable = true, },
          fold = { enable = true },
        }
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.opt.foldlevel = 1
      end,
    },
    { "lervag/vimtex",
      lazy = true,
      ft = "tex",
      init = function()
        -- VimTeX configuration goes here, e.g.
        -- vim.g.vimtex_view_method = "zathura"
      end,
    },
    { "majutsushi/tagbar",
      lazy = true,
      keys = { "<F4>", "<F8>" },
      config = function()
        vim.api.nvim_set_keymap('n', '<F4>', ':!/usr/bin/ctags -R --exclude=.git --exclude=documentation --c++-kinds=+p --langmap=c++:+.cu --fields=+liaS --extra=+q .<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true, silent = true })
      end,
    },
    { "vim-airline/vim-airline", },
    { "neovim/nvim-lspconfig",
      --config = function()
      --  local lspconfig = require("lspconfig")
      --  lspconfig.clangd.setup({})
      --end,
    },
    { "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    },
    { "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
      config = function()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "clangd"},
        })
        require("mason-lspconfig").setup_handlers({
          function(server_name)
            require("lspconfig")[server_name].setup({
              on_attach = function (_, bufnr)
                  local opts = {noremap=true, silent=true }
                  --vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', vim.tbl_extend('force', opts, { desc = "Jump to definition" }))
                  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', vim.tbl_extend('force', opts, { desc = "Jump to definition" }))
                  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', vim.tbl_extend('force', opts, { desc = "Jump to declatation" }))
                  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
                  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
                  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
                  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
                end,
              flags = {
                debounce_text_changes = 150,
              },
            })
          end,
        })
      end,
    },
    { "karb94/neoscroll.nvim",
      config = function ()
        require('neoscroll').setup({})
      end
    },
    { "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      keys = {
        {
          "<leader>?",
          function()
            require("which-key").show({ global = false })
          end,
          desc = "Buffer Local Keymaps (which-key)",
        },
      },
    },
    { "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      ---@module "ibl"
      ---@type ibl.config
      opts = {},
    },
    { "hrsh7th/nvim-cmp",
      enabled = true, -- TODO breaks lspconfig
      -- TODO add lazy loading
      dependencies = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp'
      },
      config = function()
        require'cmp'.setup {
          snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
              vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
            end,
          },
          window = {
            completion = require('cmp').config.window.bordered(),
            documentation = require('cmp').config.window.bordered(),
          },
          mapping = require('cmp').mapping.preset.insert({
            ['<C-d>'] = require('cmp').mapping.scroll_docs(-4),
            ['<C-f>'] = require('cmp').mapping.scroll_docs(4),
            ['<C-Space>'] = require('cmp').mapping.complete(),
            ['<C-e>'] = require('cmp').mapping.close(),
            ['<CR>'] = require('cmp').mapping.confirm({ select = true }),
          }),
          sources = {
            { name = 'nvim_lsp' },
            { name = 'buffer' },
          },
          -- Use buffer source for `/` and `?` code completion (if you enabled `native_menu`, this won't work anymore).
          require('cmp').setup.cmdline({ '/', '?' }, {
            mapping = require('cmp').mapping.preset.cmdline(),
            sources = {
              { name = 'buffer' }
            }
          }),
          -- Use cmdline & path source for ':' code completion (if you enabled `native_menu`, this won't work anymore).
          require('cmp').setup.cmdline(':', {
            mapping = require('cmp').mapping.preset.cmdline(),
            sources = require('cmp').config.sources({
              { name = 'path' }
            }, {
              { name = 'cmdline' }
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
          }),
          -- Set up lspconfig.
          require('lspconfig')['clangd'].setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          },
          require('lspconfig')['lua_ls'].setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          }
        }
      end,
    },
    {'nvim-telescope/telescope.nvim',
      enabled = true,
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      end,
    },
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    auto_install = true,
  },
})
