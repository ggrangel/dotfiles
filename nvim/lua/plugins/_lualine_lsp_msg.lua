local M = {}

local get_lsp_clients = function(ft)
	local clients = vim.lsp.get_active_clients()
	local clients_name = {}

	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, ft) ~= -1 then
			table.insert(clients_name, client.name)
		end
	end

	return clients_name
end

local function get_conform_clients(ft)
	local clients = {}
	local formatters_by_ft = require("conform").formatters_by_ft

	if formatters_by_ft[ft] then
		for _, formatter in ipairs(formatters_by_ft[ft]) do
			table.insert(clients, formatter)
		end
	end

	return clients
end

local function get_nvimlint_clients(ft)
	local clients = {}
	local linters_by_ft = require("lint").linters_by_ft

	if linters_by_ft[ft] then
		for _, linter in ipairs(linters_by_ft[ft]) do
			table.insert(clients, linter)
		end
	end

	return clients
end

local function safe_extend(dest, src)
	-- Check if the source table is not nil to avoid errors
	if src then
		for _, item in ipairs(src) do
			table.insert(dest, item)
		end
	end
end

M.list_attached_lsp_clients = function()
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")

	local lsp_clients = get_lsp_clients(buf_ft)
	local conform_clients = get_conform_clients(buf_ft)
	local nvimlint_clients = get_nvimlint_clients(buf_ft)

	local all_clients = {}

	safe_extend(all_clients, lsp_clients)
	safe_extend(all_clients, conform_clients)
	safe_extend(all_clients, nvimlint_clients)

	return table.concat(all_clients, ", ")
end

M.rm_cwd_from_path = function()
	local path = vim.fn.expand("%:p")
	local cwd = vim.fn.getcwd()
	local removed = path:sub(#cwd + 2) -- Add 2 to account for the leading slash and the extra slash
	return removed
end

return M
