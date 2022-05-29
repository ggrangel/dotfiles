local null_ls = require "null-ls"

--> There is no plugin linke lspinstaller for linters/formmaters.
--> You need to install the source's binary (pacman/AUR should have all of them)

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  debug = false,
  sources = {
    --> Formatters <--
    formatting.black,
    formatting.isort,
    formatting.shfmt,
    formatting.stylua.with {
      indent_width = 2,
    },
    --> formatting.standardrb,
    formatting.prettier_standard.with {
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
    },
    --> Linters <--
    diagnostics.shellcheck,
  },
  on_attach = function(client, _)
    if client.resolved_capabilities.document_formatting then
      -- formatting_seq_sync() formats with all language server (instead of keeping asking which one you wanna use in case you have multiple installed)
      -- as an alternative, you can choose a source to disable its formatting capability (like I did for tsserver)
      vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()"
    end
  end,
}
