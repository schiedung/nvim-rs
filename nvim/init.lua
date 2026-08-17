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
-- Map Esc in terminal mode to exit to normal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-N>', { silent = true, desc = "Terminal: exit to normal mode" })
vim.keymap.set('n', '<leader>ln', function()
  vim.opt.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle relative line numbers" })

-- Regenerate ctags for the current directory. Uses `ctags` from PATH rather than
-- a hardcoded /usr/bin so it also works on Homebrew/Nix/snap installs.
vim.keymap.set('n', '<F4>',
  ':!ctags -R --exclude=.git --exclude=documentation --c++-kinds=+p '
  .. '--langmap=c++:+.cu --fields=+liaS --extra=+q .<CR>',
  { silent = true, desc = "Regenerate ctags" })

-- Buffer-local LSP keybindings.
-- NOTE: Neovim 0.11+ already provides grr (references), grn (rename), gra (code
-- action), gri (implementation), grt (type definition) and K (hover) by default,
-- so those are deliberately NOT redefined here. Mapping bare `gr` in particular
-- would put a completed match on the `gr*` prefix and make every `gr` press wait
-- out 'timeoutlen'. Only mappings the defaults do not cover live below.
local function on_attach(_, bufnr)
  local function map(lhs, rhs, desc)
    vim.keymap.set('n', lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  map('gd', vim.lsp.buf.definition, 'LSP: go to definition')
  map('gD', vim.lsp.buf.declaration, 'LSP: go to declaration')
  map('gi', vim.lsp.buf.implementation, 'LSP: go to implementation')
  map('<C-k>', vim.lsp.buf.signature_help, 'LSP: signature help')
  map('[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Previous diagnostic')
  map(']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Next diagnostic')
  map('<space>e', vim.diagnostic.open_float, 'Show diagnostic in a float')
  map('<space>q', vim.diagnostic.setloclist, 'Diagnostics to location list')
end

-- Apply the mappings above whenever a language server attaches to a buffer.
-- Servers themselves are enabled in the nvim-lspconfig spec below.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
  end,
})

-- File type autocmds
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
    { "rebelot/kanagawa.nvim", -- my custom colorscheme
      lazy = false, -- always load this plugin
      priority = 1000, -- load this plugin before all others
      config = function()
        vim.cmd([[colorscheme kanagawa]])
      end,
    },
    { "nvim-neo-tree/neo-tree.nvim", -- file tree plugin
      -- The keys below both lazy-load the plugin and are the actual mappings,
      -- so there is a single source of truth. A bare string here would be a
      -- load trigger only, which is why "<cmd>Neotree<CR>" used to sit in this
      -- list as a mapping for a key sequence nobody can type.
      cmd = "Neotree",
      keys = {
        { "<C-n>", "<cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
        { "<leader>n", "<cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
      },
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
    },
    { "github/copilot.vim",
      enabled = true,
    },
    {
      "robitx/gp.nvim",
      -- NOTE: must have a load trigger. With a bare `lazy = true` and nothing
      -- requiring the module, setup() never ran and no :Gp* command existed.
      -- `cmd` makes lazy create these as stubs at startup, so they are available
      -- immediately and load the plugin on first use. VeryLazy is kept as a
      -- belt-and-braces trigger so the full generated command set registers even
      -- if one is missing from the list below.
      event = "VeryLazy",
      cmd = {
        "GpAgent", "GpAppend", "GpChatDelete", "GpChatFinder", "GpChatLast",
        "GpChatNew", "GpChatPaste", "GpChatRespond", "GpChatToggle", "GpContext",
        "GpEnew", "GpNew", "GpNextAgent", "GpPopup", "GpPrepend", "GpRewrite",
        "GpSelectAgent", "GpStop", "GpTabnew", "GpVnew",
      },
      config = function()
        local conf = {
          openai_api_key = os.getenv("OPENAI_API_KEY"),
          providers = {
            ollama = {
              endpoint = "http://localhost:11434/v1/chat/completions",
            },
          },
          agents = {
            {
              name = "ChatOllamaLlama3.1-8B",
              disable = true,
            },
            {
              name = "Yoda",
              provider = "ollama",
              chat = true,
              command = true,
              model = { model = "codellama:latest" },
              system_prompt = "Please imitate master Yoda from Star Wars when answering.",
            },
          },
        }
        require("gp").setup(conf)
        end,
    },
    { "godlygeek/tabular"},
    { "m4xshen/hardtime.nvim",
       dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
       opts = { disable_mouse = false}
    },
    {"tpope/vim-fugitive", -- premier git plugin
      -- Deliberately NOT lazy-loaded: fugitive provides commands (:Git, :Gblame,
      -- :Gedit, ...) and fugitive:// buffer handling well beyond the five keys
      -- mapped here, so gating it on those keys would hide most of the plugin.
      config = function()
        -- Commands spelled in full. `:Gvdiff` does still work as an unambiguous
        -- abbreviation of `:Gvdiffsplit`, but that breaks silently the day
        -- fugitive adds any other Gvdiff* command.
        local map = function(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { silent = true, desc = desc })
        end
        map('<leader>gw', '<cmd>Gwrite<CR>', 'Git: stage current file')
        map('<leader>gr', '<cmd>Gread<CR>', 'Git: checkout current file')
        map('<leader>gs', '<cmd>Git status<CR>', 'Git: status')
        map('<leader>gd', '<cmd>Gvdiffsplit<CR>', 'Git: diff (vertical split)')
        map('<leader>gc', '<cmd>Git commit<CR>', 'Git: commit')
      end,
    },
    { "nvim-treesitter/nvim-treesitter", -- syntax highlighting
      -- Pin to master: this config uses the classic `nvim-treesitter.configs`
      -- API, which does not exist on the `main` branch. Upstream intends to make
      -- `main` the default, at which point an unpinned fresh clone would fail at
      -- startup. Migrating to the main API is the eventual fix.
      branch = "master",
      build = ":TSUpdate",
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
          -- NOTE: there is no `fold` module in nvim-treesitter (only highlight,
          -- incremental_selection and indent), so a `fold = {...}` key here is
          -- silently discarded. Folding comes from the three options below.
        }
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.opt.foldlevel = 1
      end,
    },
    { "lervag/vimtex",
      lazy = true,
      ft = "tex",
    },
    { "majutsushi/tagbar",
      -- Only <F8> needs tagbar; <F4> is a plain ctags shell command and is
      -- mapped globally near the top of this file instead.
      cmd = { "TagbarToggle", "TagbarOpen", "TagbarClose" },
      keys = {
        { "<F8>", "<cmd>TagbarToggle<CR>", desc = "Toggle tagbar" },
      },
    },
    { "vim-airline/vim-airline", },
    { "neovim/nvim-lspconfig", -- ships lsp/<server>.lua definitions for vim.lsp.enable
      dependencies = { "williamboman/mason.nvim" }, -- mason puts its bin dir on PATH first
      config = function()
        vim.lsp.enable({ "clangd", "lua_ls" })
      end,
    },
    { "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
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
    { "lukas-reineke/indent-blankline.nvim", --  adds indentation guides to Neovim
      -- Needs a trigger: with a bare `lazy = true` and nothing requiring "ibl",
      -- this never loaded and the indent guides never rendered.
      event = { "BufReadPost", "BufNewFile" },
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      main = "ibl",
      ---@module "ibl"
      ---@type ibl.config
      opts = {},
    },
    {'nvim-telescope/telescope.nvim',
      cmd = "Telescope",
      dependencies = { 'nvim-lua/plenary.nvim' },
      keys = {
        { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Telescope find files' },
        { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Telescope live grep' },
        { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Telescope buffers' },
        { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Telescope help tags' },
      },
    },
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- Check for plugin updates and notify; updates are applied by :Lazy update.
  -- NOTE: `auto_install` is NOT a valid checker option (the real ones are
  -- enabled/concurrency/notify/frequency/check_pinned) and was silently ignored.
  checker = {
    enabled = true,
  },
  -- No plugin here needs luarocks; disabling it keeps :checkhealth clean instead
  -- of reporting a hererocks error for a feature we never use.
  rocks = { enabled = false },
})
