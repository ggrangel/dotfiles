-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
       autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

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

	use("unblevable/quick-scope")
	use("tpope/vim-rails")

	use("ThePrimeagen/refactoring.nvim")

	-- Misc
	use("ThePrimeagen/vim-be-good")
	use("vimwiki/vimwiki")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("ThePrimeagen/harpoon")

	-- Extra features
	use("kyazdani42/nvim-tree.lua")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb") -- :GBrowse command
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use("tpope/vim-sleuth") -- automatically adjusts 'shiftwidth' and 'expandtab' based on the current file

	-- Remaps
	use("machakann/vim-sandwich") -- like vim-surround but highlights text and also supports dot command
	use("tpope/vim-commentary")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("windwp/nvim-autopairs")
	use("andrewradev/splitjoin.vim") -- gS (not working) and gJ commands

	-- Colorschemes and Appearance
	use("gruvbox-community/gruvbox")
	use("lunarvim/darkplus.nvim")
	use("p00f/nvim-ts-rainbow")
	use({ "rrethy/vim-hexokinase", run = "make hexokinase" }) -- shows color as a virtual text
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Completions
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua") -- for neovim API (if I ever develop a plugin)

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
	use("mattn/emmet-vim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		-- module = "telescope",
		-- cmd = "Telescope", -- only starts when we run this command. check :PackerStatus before running it
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	})
	use("dhruvmanila/telescope-bookmarks.nvim")
end)
