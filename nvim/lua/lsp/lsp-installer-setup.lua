local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		-- importing M.on_attach and M.capabilities from lsp.handlers file
		on_attach = require("lsp-setup/handlers").on_attach,
		capabilities = require("lsp-setup/handlers").capabilities,
	}

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("lsp-setup/settings/sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
