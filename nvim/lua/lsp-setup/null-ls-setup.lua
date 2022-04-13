local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		formatting.black,
		formatting.isort,
		formatting.latexindent,
		formatting.shfmt,
		formatting.stylua,
		-- formatting.codespell.with({ filetypes = { "markdown", "vimwiki" } }),
		-- formatting.prettier, -- .with({extra_args = {"--no-semi", "--single-quote", "--jsx-single-quote"}}),
		formatting.prettier_standard.with({
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"jsonc",
				"yaml",
				"markdown",
				"graphql",
				"handlebars",
			},
		}),
		-- code_actions.xo,
		-- diagnostics.flake8,
		diagnostics.shellcheck,
		-- diagnostics.luacheck, -- too many false positive, needs setup
		-- diagnostics.stylelint,
		-- diagnostics.eslint_d,
		-- code_actions.proselint.with({ filetypes = { "vimwiki" } }),
	},
	on_attach = function(client, bufnr)
		if client.resolved_capabilities.document_formatting then
			-- formatting_seq_sync() formats with all language server (instead of keeping asking which one you wanna use in case you have multiple installed)
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
		end

		Lsp_keymaps(bufnr)
	end,
})
