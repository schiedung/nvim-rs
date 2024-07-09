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
    { "tpope/vim-fugitive", -- premier git plugin
      config = function()
          vim.api.nvim_set_keymap('n', '<leader>gw', ':Gwrite<CR>', { noremap = true, silent = true })
          vim.api.nvim_set_keymap('n', '<leader>gr', ':Gread<CR>', { noremap = true, silent = true })
          vim.api.nvim_set_keymap('n', '<leader>gs', ':Git status<CR>', { noremap = true, silent = true })
          vim.api.nvim_set_keymap('n', '<leader>gd', ':Gitvdiff<CR>', { noremap = true, silent = true })
          vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', { noremap = true, silent = true })
      end,
    },
    { "nvim-treesitter/nvim-treesitter", -- syntax highlighting
      config = function()
	require'nvim-treesitter.configs'.setup {
	  ensure_installed = {"lua", "c", "cpp", "cuda", "python", "bash", "markdown"},
	  highlight = {
	    enable = true,
	  },
	}
      end
    },
    { "lervag/vimtex",
      lazy = true,
      ft = "tex",
      init = function()
        -- VimTeX configuration goes here, e.g.
        -- vim.g.vimtex_view_method = "zathura"
      end
    }
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
