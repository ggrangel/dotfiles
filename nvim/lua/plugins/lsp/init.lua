local handlers = require("plugins/lsp/handlers")

handlers.setup()

require("mason").setup()

local lspconfig = require("lspconfig")

local servers = {
  "bashls",
  "tsserver",
  "lua_ls",
  "pyright",
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

-- press this key twice in order to focus on the diagnostic window
-- useful for yanking the text
vim.keymap.set("n", "gl", function()
  return vim.diagnostic.open_float({ border = "rounded" })
end)
