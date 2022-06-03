-- Reloads vim whenever you save this file
vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost",
  { pattern = { "packer-setup.lua" }, command = "source <afile> | PackerSync", group = "packer_user_config" }
)

-- Have packer use a popup window
require("packer").init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require("packer").startup(function()
  use "wbthomason/packer.nvim"
  -- use "/home/rangelgbr/apps/plugins/autosnips/"

  -- Misc
  use "lewis6991/impatient.nvim" -- Speed up loading Lua modules in Neovim to improve startup time.
  use { "vimwiki/vimwiki", config = require "plugins.vimwiki" }
  -- use "tpope/vim-sleuth" -- automatically adjusts 'shiftwidth' and 'expandtab' based on the current file... not working anymore?
  use "dstein64/vim-startuptime"

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = require "plugins.treesitter" }
  use "p00f/nvim-ts-rainbow"
  use { "nvim-treesitter/playground" }
  use "RRethy/nvim-treesitter-textsubjects"
  use "nvim-treesitter/nvim-treesitter-textobjects"

  -- Navigation
  use { "unblevable/quick-scope", config = require "plugins.quick-scope" }
  use { "ThePrimeagen/harpoon", config = require "plugins.harpoon" }
  use "tpope/vim-rails"
  use { "ggandor/leap.nvim", config = require("leap").set_default_keymaps() }

  -- Remaps
  use "machakann/vim-sandwich" -- like vim-surround but highlights text and also supports dot command
  use { "windwp/nvim-autopairs", config = require "plugins.autopairs" }
  use { "numToStr/Comment.nvim", config = require "plugins.comment" }

  --> Appearance and GUI <--
  use "lunarvim/darkplus.nvim"
  -- use { "catppuccin/nvim", as = "catppuccin" }
  use { "lewis6991/gitsigns.nvim", config = require "plugins.gitsigns" } -- git decorations
  use { "rrethy/vim-hexokinase", run = "make hexokinase" } -- shows color as a virtual text
  use "kyazdani42/nvim-web-devicons" -- Required by many plugins
  use { "stevearc/dressing.nvim", config = require "plugins.dressing" } --> beautiful vim.ui.select and vim.ui.input
  use { "folke/trouble.nvim", config = require "plugins.trouble" } --> pretty list of LSP diagnostics and references
  use { "rcarriga/nvim-notify", config = require "plugins.notify" } --> notification manager
  use "RRethy/vim-illuminate"

  --> GUI <--
  use { "nvim-lualine/lualine.nvim", config = require "plugins.lualine" }
  use "mbbill/undotree"
  use { "kyazdani42/nvim-tree.lua", config = require "plugins.nvimtree" }
  use "simeji/winresizer" -- Easy resizing of vim windows (press <c-w>)

  -- Completion
  use { "hrsh7th/nvim-cmp", config = require "plugins.cmp" }
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua" --> completion source for nvim lua api
  use "saadparwaiz1/cmp_luasnip"

  -- Snippets
  use { "L3MON4D3/LuaSnip", config = require "plugins.luasnip-setup" }
  use { "rafamadriz/friendly-snippets", config = require "plugins.friendly-snippets" }
  use "mattn/emmet-vim"

  -- LSP
  use { "neovim/nvim-lspconfig", config = require "plugins.lsp" }
  use "williamboman/nvim-lsp-installer"
  use { "jose-elias-alvarez/null-ls.nvim", config = require "plugins/null-ls" } -- for formatters and linters
  use "onsails/lspkind.nvim" --> add pictograms to neovim lsp

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" }, -- dependency
      { "burntsushi/ripgrep" }, -- necessary for live_grep picker
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }, -- better sorgint performance
      { "nvim-telescope/telescope-ui-select.nvim" }, --> sets vim.ui.select to telescope
    },
    config = require "plugins.telescope",
  }
end)
