local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  sources = {
    code_actions.gitsigns,
    formatting.gofmt,
    formatting.goimports,
    -- formatting.golines,
    formatting.prettierd.with({
      filetypes = { "json", "yaml", "html" },
    }),
    formatting.shfmt.with({
      filetypes = { "sh", "bash", "zsh" },
    }),
    formatting.stylua,
    diagnostics.staticcheck,
    diagnostics.golangci_lint,
    -- diagnostics.revive, -- too much "unexported warnings"
    diagnostics.sempgrep,
    diagnostics.hadolint,
    -- formatting.pg_format,
    diagnostics.sqlfluff.with({
      extra_args = { "--dialect", "postgresql" },
    }),
    diagnostics.selene, -- too many false positives
    diagnostics.yamllint,
    diagnostics.zsh,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

local nvimlint = require("lint")
nvimlint.linters_by_ft = {
  ghactions = { "actionlint" },
  sh = { "shellcheck" },
}
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    nvimlint.try_lint()
  end,
})

GetAllLinters = function()
  local allLinters = {}
  for ft, ft_linters in pairs(nvimlint.linters_by_ft) do
    if ft == vim.bo.filetype then
      for _, linter in ipairs(ft_linters) do
        table.insert(allLinters, linter)
      end
    end
  end
  return table.concat(allLinters, ", ")
end
