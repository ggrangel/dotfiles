local nvimlint = require("lint")
nvimlint.linters_by_ft = {
	ghactions = { "actionlint" },
	go = { "golangcilint" },
	sh = { "shellcheck" },
	yaml = { "yamllint" },
	zsh = { "zsh" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		-- try_lint without arguments runs the linters defined in `linters_by_ft`
		-- for the current filetype
		nvimlint.try_lint()
	end,
})

-- For a list of linters see:
-- help nvim-lint-available-linters
