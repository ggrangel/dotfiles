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
      "mlaursen/vim-react-snippets",
    },
    config = function()
      require("plugins/cmp")
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
    -- Provides language server capabilities to tools that doesn't conform to the LSP (ex: prettier)
    "nvimtools/none-ls.nvim",
    -- event = "VeryLazy",
    config = function()
      require("plugins/null-ls")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins/lualine")
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
    "rebelot/kanagawa.nvim", -- color theme
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
  {
    "windwp/nvim-ts-autotag", -- handles html tags
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    -- Better replacement for typescript-languange-server (tsserver)
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    -- config = function()
    --   require("typescript-tools").setup()
    -- end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local refactoring = require("refactoring")
      refactoring.setup()
      vim.keymap.set({ "n", "x" }, "<leader>rr", function()
        refactoring.select_refactor()
      end)
    end,
  },
  {
    "lewis6991/whatthejump.nvim", -- displays the jump list in a floating window
  },
  {
    "voxelprismatic/rabbit.nvim",
    config = function()
      require("rabbit").setup({
        colors = {
          title = {   -- Title text
            fg = "#000000", -- Grabs from :hi Normal
            bold = true,
          },
          index = {   -- Index numbers
            fg = "#000000", -- Grabs from :hi Comment
            italic = true,
          },
          dir = "#000000", -- Folders; Grabs from :hi NonText

          file = "#000000", -- File name; Grabs from :hi Normal

          term = {     -- Addons, eg :term or :Oil
            fg = "#000000", -- Grabs from :hi Constant
            italic = true,
          },
          noname = {  -- No buffer name set
            fg = "#000000", -- Grabs from :hi Function
            italic = true,
          },
        },

        window = {
          -- If `box_style` is specified, it will overwrite anything set in `box`
          box_style = "round", -- One of "round", "square", "thick", "double"
          box = {
            top_left = "╭", -- Top left corner of box
            top_right = "╮", -- Top right corner of box
            bottom_left = "╰", -- Bottom left corner of box
            bottom_right = "╯", -- Bottom right corner of box
            vertical = "│", -- Vertical wall
            horizontal = "─", -- Horizontal ceiling
            emphasis = "═", -- Emphasis around title, like `──══ Rabbit ══──`
          },

          width = 64, -- Width, in columns
          height = 24, -- Height, in rows

          -- Where the plugin name should be displayed.
          -- * "bottom" means in the bottom left corner, but not displayed in full screen
          -- * "title" means next to rabbit, eg `──══ Rabbit History ══──`
          -- * "hide" means to not display it at all
          plugin_name_position = "bottom",

          title = "Rabbit", -- Title text, eg: `──══ Rabbit ══──` or `──══ NotHarpoon ══──`

          emphasis_width = 8, -- Eg: `──────══ Rabbit ══──────` or `──══════ Rabbit ══════──`

          float = true,  -- Plain `true` means use bottom right corner
          float = {
            top = 10000, -- Top offset in lines
            left = 10000, -- Left offset in columns
          },
          float = {
            "bottom", -- "top" or "bottom;" MUST BE FIRST
            "right", -- "left" or "right;" MUST BE LAST
          },

          -- When using split screen, it will try to use the width and height provided earlier.
          -- Eg, when splitting left or right: height = 100%; width = `width`
          -- Eg, when splitting above or below: height = `height`; width = 100%
          -- NOTE: `float` must be explicitly set to false in order to split
          -- NOTE: If both `float` and `split` are false, a new buffer will open, "fullscreen"
          split = true, -- Plain `true` means use the right side
          split = "right", -- One of "left", "right", "above", "below"

          overflow = ":::", -- String to display when folders overflow
          path_len = 12, -- How many characters to display in folder name before cutting off
        },

        default_keys = {
          close = { -- Default bindings to close Rabbit
            "<Esc>",
            "q",
            "<leader>",
          },

          select = { -- Default bindings to select a buffer
            "<CR>",
          },

          open = { -- Default bindings to open Rabbit
            "<leader>r",
          },

          file_add = { -- Default bindings to add current buffer to persistent history
            "a",  -- This would act like Prime's Harpoon, but it isn't implemented yet
          },

          file_del = { -- Default bindings to remove current buffer from persistent history
            "d",  -- This would act like Prime's Harpoon, but it isn't implemented yet
          },
        },

        plugin_opts = {  -- Plugin specific options you'd like to set
          history = {
            color = "#d7827e", -- Border color
            switch = "r", -- Keybind to switch to the history window from within Rabbit
            keys = {},   -- See the API for more details
            opts = {},   -- See the API for more details
          },
          reopen = {
            color = "#907aa9", -- Border color
            switch = "o", -- Keybind to switch to the reopen window from within Rabbit
            keys = {},   -- See the API for more details
            opts = {},   -- See the API for more details
          },
        },

        enable = { -- Builtin plugins to enable immediately
          "history", -- The plugin shown when opening Rabbit
          "reopen",
          "oxide",
        },
      })
      vim.keymap.set({ "n", "x" }, "<leader>R", ":Rabbit<CR>")
    end,
  },
})
