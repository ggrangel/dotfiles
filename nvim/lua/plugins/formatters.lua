local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		bash = { "shfmt" },
		go = { "gofmt", "goimports" },
		html = { "prettierd" },
		json = { "prettierd" },
		lua = { "stylua" },
		sh = { "shfmt" },
		yaml = { "prettierd" },
		zsh = { "shfmt" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

-- For a list of formatters see:
-- help conform-formatters
