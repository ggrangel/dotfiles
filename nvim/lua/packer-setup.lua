-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
    augroup packer_user_config
       autocmd!
        autocmd BufWritePost packer-setup.lua source <afile> | PackerSync
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

	-- Misc
	use("lewis6991/impatient.nvim") -- Speed up loading Lua modules in Neovim to improve startup time.
	use("vimwiki/vimwiki")
	use("tpope/vim-sleuth") -- automatically adjusts 'shiftwidth' and 'expandtab' based on the current file
	use("dstein64/vim-startuptime")
	use("ibhagwan/fzf-lua")

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- Navigation
	use("unblevable/quick-scope")
	use("ThePrimeagen/harpoon")
	use("tpope/vim-rails")
	use({ "ggandor/leap.nvim", configs = { require("leap").set_default_keymaps() } })

	-- Remaps
	use("machakann/vim-sandwich") -- like vim-surround but highlights text and also supports dot command
	use("windwp/nvim-autopairs")
	use("numToStr/Comment.nvim")

	--> Appearance and GUI <--
	use("lunarvim/darkplus.nvim")
	use("lewis6991/gitsigns.nvim") -- git decorations
	use({ "rrethy/vim-hexokinase", run = "make hexokinase" }) -- shows color as a virtual text
	use("kyazdani42/nvim-web-devicons") -- Required by many plugins
	use("stevearc/dressing.nvim") --> beautiful vim.ui.select and vim.ui.input
	use("folke/trouble.nvim") --> pretty list of LSP diagnostics and references
	use({ "rcarriga/nvim-notify", config = "vim.notify = require('notify')" }) --> notification manager

	--> GUI <--
	use("nvim-lualine/lualine.nvim")
	use("mbbill/undotree")
	use("kyazdani42/nvim-tree.lua")
	use("simeji/winresizer") -- Easy resizing of vim windows (press <c-w>)

	-- Completion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua") --> completion source for nvim lua api
	use("saadparwaiz1/cmp_luasnip")

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
	use("mattn/emmet-vim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
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
	})
end)