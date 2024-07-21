require("mason").setup()
local lspconfig = require("lspconfig")

local handlers = {}

handlers.on_attach = function(client, bufnr)
  -- highlights other uses of the word under cursor using LSP and treesitter
  require("illuminate").on_attach(client)
  -- trying to disable inlay hint but it's not working. Something else is enabling it :(
  -- if client.server_capabilities.inlayHintProvider then
  --   vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
  -- end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")

handlers.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
handlers.capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
  "bashls",
  "dockerls",
  "eslint",
  "gopls",
  "lua_ls",
  "pyright",
  "sqlls",
  "tailwindcss",
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  local has_custom_opts, server_custom_opts = pcall(require, "plugins/lsp/settings/" .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end

  lspconfig[server].setup(opts)
end

require("mason-lspconfig").setup({
  ensure_installed = servers,
})

vim.diagnostic.config({ virtual_text = { source = true } })
-- toggle vim.diagnostic lsp inlay hints
vim.keymap.set("n", "<leader>cn", function()
  vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end)

-- press this key twice in order to focus on the diagnostic window
-- useful for yanking the text
vim.keymap.set("n", "gl", function()
  return vim.diagnostic.open_float({ border = "rounded" })
end)

vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<space>gt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- nvim lsp defaults:
-- vim.keymap.set("n", "[d", function()
--   return vim.diagnostic.goto_prev({ border = "rounded" })
-- end)
-- vim.keymap.set("n", "]d", function()
--   return vim.diagnostic.goto_next({ border = "rounded" })
-- end)
-- vim.keymap.set("n", "K", vim.lsp.buf.hover)
