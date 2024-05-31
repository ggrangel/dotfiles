local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
  {
    "vimwiki/vimwiki",
    config = function()
      require("plugins.vimwiki")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end,
  },
  {
    "machakann/vim-sandwich",
    config = function()
      require("plugins.vim-sandwich")
    end,
  },                                                -- like vim-surround but highlights text and also supports dot command
  { "RRethy/nvim-treesitter-textsubjects" },
  { "nvim-treesitter/nvim-treesitter-textobjects" }, -- define custom textobjects (like "f" for function and "c" for conditionals)
  { "nvim-treesitter/nvim-treesitter-context" },    -- sticky header for context
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup({
        highlight_on_key = true,
      })
    end,
  },
  -- {
  --   "unblevable/quick-scope",
  --   -- enabled = true,
  --   config = function()
  --     require("plugins.quick-scope") -- helps with horizontal navigation (f and t)
  --   end,
  -- },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },                               -- dependency
      { "burntsushi/ripgrep" },                                  -- necessary for live_grep picker
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }, -- better sorgint performance
      { "nvim-telescope/telescope-ui-select.nvim" },             --> sets vim.ui.select to telescope
    },
    config = function()
      require("plugins.telescope")
    end,
  },
  -- entireBuffer: gG (useful for yanking whole file)
  -- key of key-value pair, or left side of a variable assignment: ik, ak
  -- value of key-value pair, or right side of a variable assignment: iv, av
  -- number: in, an
  -- mdFencedCodeBlock: iC, aC
  {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
      require("various-textobjs").setup({ useDefaultKeymaps = true })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("plugins.harpoon")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  },                                 -- git decorations
  { "kyazdani42/nvim-web-devicons" }, -- Required by many plugins
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",  --> completion source for nvim lua api
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip", -- communicatoin between luasnip and cmp
    },
    config = function()
      require("plugins.cmp")
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs") -- auto pair for (), [], {}, "" etc...
    end,
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_keymaps() -- vertical navigation
    end,
  },
  { "RRethy/vim-illuminate" }, -- highlights other uses of the word under cursor using LSP and treesitter
  { "mbbill/undotree" },      -- enables to undo even after restarting nvim
  {
    "gbprod/yanky.nvim",      -- highlights on yank
    config = function()
      require("plugins.yanky")
    end,
  },

  {
    "neovim/nvim-lspconfig", -- provides basic configurations of LSP servers
    config = function()
      require("plugins.lsp")
    end,
  },
  { "williamboman/mason.nvim" },          -- provides a repository and frontend that helps a user manage the installation of various third-party tools (LSP servers, formatters, linters)
  { "williamboman/mason-lspconfig.nvim" }, -- uses Mason to ensure installation of user specified LSP servers and will tell nvim-lspconfig what command to use to launch those servers (that is, it's a bridge between the 2 former plugins)
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins/null-ls")
    end,
  }, -- for formatters and linters
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  },
  { "simeji/winresizer" }, -- Easy resizing of vim windows (press <c-w>)
  {
    "stevearc/oil.nvim",
    config = function()
      require("plugins/oil")
    end,
  },
  {
    "rebelot/kanagawa.nvim",
  },
  {
    "github/copilot.vim",
  },
  {
    "folke/trouble.nvim",
    config = function()
      require("plugins/trouble")
    end,
  },
  {
    {
      "robitx/gp.nvim",
      config = function()
        require("plugins/gp-nvim")
      end,
    },
  },
})
