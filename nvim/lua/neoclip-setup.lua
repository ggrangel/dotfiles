require("neoclip").setup({
	history = 1000,
	enable_persistent_history = true,
	db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
	filter = nil,
	preview = true,
	default_register = '"',
	default_register_macros = "q",
	enable_macro_history = true,
	content_spec_column = false,
	on_paste = {
		set_reg = true,
	},
	on_replay = {
		set_reg = false,
	},
	keys = {
		telescope = {
			i = {
				select = "<CR>",
				paste = "<c-p>",
				paste_behind = "<c-k>",
				replay = "<c-q>",
				custom = {},
			},
			n = {
				select = "<CR>",
				paste = "p",
				paste_behind = "P",
				replay = "q",
				custom = {},
			},
		},
		fzf = {
			select = "default",
			paste = "ctrl-p",
			paste_behind = "ctrl-k",
			custom = {},
		},
	},
})
