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

	-- Misc
	use("lewis6991/impatient.nvim") -- Speed up loading Lua modules in Neovim to improve startup time.
	use("vimwiki/vimwiki")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("mbbill/undotree")
	use("folke/trouble.nvim")
	use("simeji/winresizer") -- Easy resizing of vim windows (press <c-w>)

	-- Navigation
	use("unblevable/quick-scope")
	use("ThePrimeagen/harpoon")
	use("tpope/vim-rails")
	use("ggandor/leap.nvim")

	-- Remaps
	use("machakann/vim-sandwich") -- like vim-surround but highlights text and also supports dot command
	use("windwp/nvim-autopairs")
	use("tpope/vim-commentary")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Appearance
	use("lunarvim/darkplus.nvim")
	use("p00f/nvim-ts-rainbow")
	use({ "rrethy/vim-hexokinase", run = "make hexokinase" }) -- shows color as a virtual text
	use("nvim-lualine/lualine.nvim")
	use("kyazdani42/nvim-tree.lua")
	use("kyazdani42/nvim-web-devicons") -- Required by many plugins
	use("tpope/vim-sleuth") -- automatically adjusts 'shiftwidth' and 'expandtab' based on the current file

	-- Completion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua") -- for neovim API (if I ever develop a plugin)
	use("saadparwaiz1/cmp_luasnip")

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
	use("mattn/emmet-vim")

	-- LSP
	use("neovim/nvim-lspconfig")
	-- use({ "ray-x/navigator.lua", requires = { "ray-x/guihua.lua", run = "cd lua/fzy && make" } })
	use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "burntsushi/ripgrep" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
	})
end)
