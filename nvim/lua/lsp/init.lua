local lspconfig = require("lspconfig")

local handler = require("lsp/handlers")

handler.setup()

local servers = { "pyright", "bashls", "tsserver", "html" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = handler.on_attach,
		capabilities = handler.capabilities,
	})
end
