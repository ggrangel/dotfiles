-- Reloads vim whenever you save this file
vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { pattern = { "packer-setup.lua" }, command = "source <afile> | PackerSync", group = "packer_user_config" }
)

-- Have packer use a popup window
require("packer").init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return require("packer").startup(function()
  use("wbthomason/packer.nvim")
  -- use "/home/rangelgbr/apps/plugins/autosnips/"

  -- Misc

  use("sbulav/nredir.nvim")

  use("lewis6991/impatient.nvim") -- Speed up loading Lua modules in Neovim to improve startup time.
  use({
    "vimwiki/vimwiki",
    config = function()
      require("plugins.vimwiki")
    end,
  })
  -- use "tpope/vim-sleuth" -- automatically adjusts 'shiftwidth' and 'expandtab' based on the current file... not working anymore?
  use("dstein64/vim-startuptime")
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })
  use({
    "Pocco81/auto-save.nvim",
    config = function()
      require("plugins.autosave") -- using only in markdown files
    end,
  })

  use({
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup() -- better scroll
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  })
  use("p00f/nvim-ts-rainbow") -- colored parentheses
  use({ "nvim-treesitter/playground" })
  use("RRethy/nvim-treesitter-textsubjects")
  use("nvim-treesitter/nvim-treesitter-textobjects") -- define custom textobjects (like "f" for function and "c" for conditionals)
  use("nvim-treesitter/nvim-treesitter-context") -- sticky header for context

  -- Navigation
  use({
    "unblevable/quick-scope",
    config = function()
      require("plugins.quick-scope") -- helps with horizontal navigation (f and t)
    end,
  })
  use({
    "ThePrimeagen/harpoon",
    config = function()
      require("plugins.harpoon")
    end,
  })
  use({
    "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_keymaps() -- vertical navigation
    end,
  })

  -- Remaps
  use("machakann/vim-sandwich") -- like vim-surround but highlights text and also supports dot command
  use({
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs") -- auto pair for (), [], {}, "" etc...
    end,
  })
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.comment")
    end,
  })

  --> Appearance and GUI <--
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  }) -- git decorations
  use("kyazdani42/nvim-web-devicons") -- Required by many plugins
  use({
    "stevearc/dressing.nvim",
    config = function()
      require("plugins.dressing") -- improves vim.ui interfaces (input and select)
    end,
  }) --> beautiful vim.ui.select and vim.ui.input
  use({
    "folke/trouble.nvim",
    config = function()
      require("plugins.trouble") -- pretty list of diagnostics
    end,
  }) --> pretty list of LSP diagnostics and references
  use({
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.notify") -- improves notification interface
    end,
  }) --> notification manager
  use("RRethy/vim-illuminate") -- highlights other uses of the word under cursor using LSP and treesitter

  -- Color themes
  use("lunarvim/darkplus.nvim")
  -- use { "catppuccin/nvim", as = "catppuccin" }
  -- use { "lewis6991/github_dark.nvim" }

  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  })
  use("mbbill/undotree")
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.nvimtree")
    end,
  })
  use("simeji/winresizer") -- Easy resizing of vim windows (press <c-w>)
  use("vonr/align.nvim") -- especially used to align comments (press '<leader>al' in visual mode)

  use({
    "gbprod/yanky.nvim",
    config = function()
      require("plugins.yanky")
    end,
  })

  -- Completion
  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.cmp")
    end,
  })
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  -- use "hrsh7th/cmp-cmdline"
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-nvim-lua") --> completion source for nvim lua api
  use("saadparwaiz1/cmp_luasnip")

  -- Snippets
  use({
    "L3MON4D3/LuaSnip",
    config = function()
      require("plugins.luasnip-setup")
    end,
  })
  use({
    "rafamadriz/friendly-snippets",
    config = function()
      require("plugins.friendly-snippets")
    end,
  })

  -- LSP
  use({
    "neovim/nvim-lspconfig", -- provides basic configurations of LSP servers
    config = function()
      require("plugins.lsp")
    end,
  })
  use("williamboman/mason.nvim") -- provides a repository and frontend that helps a user manage the installation of various third-party tools (LSP servers, formatters, linters)
  use("williamboman/mason-lspconfig.nvim") -- uses Mason to ensure installation of user specified LSP servers and will tell nvim-lspconfig what command to use to launch those servers (that is, it's a bridge between the 2 former plugins)
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins/null-ls")
    end,
  }) -- for formatters and linters
  use("onsails/lspkind.nvim") --> add pictograms to neovim lsp

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" }, -- dependency
      { "burntsushi/ripgrep" }, -- necessary for live_grep picker
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }, -- better sorgint performance
      { "nvim-telescope/telescope-ui-select.nvim" }, --> sets vim.ui.select to telescope
    },
    config = function()
      require("plugins.telescope")
    end,
  })
end)
