local M = {}
local null_ls = require("null-ls")

local does_table_contain_element = function(table, element)
	for _, value in ipairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

local get_nullls_sources = function(buf_ft)
	local sources = null_ls.get_sources()
	local sources_name = {}

	for _, source in pairs(sources) do
		local filetypes = source.filetypes
		for ft, active in pairs(filetypes) do
			if ft == buf_ft and active == true then
				if not does_table_contain_element(sources_name, source.name) then
					table.insert(sources_name, source.name)
				end
			end
		end
	end
	return sources_name
end

local get_all_attached_clients = function(buf_ft)
	local clients = vim.lsp.get_active_clients()

	if next(clients) == nil then
		return nil
	end

	local clients_name = {}

	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			if client.name == "null-ls" then
				local nls_sources = get_nullls_sources(buf_ft)
				for _, source in ipairs(nls_sources) do
					table.insert(clients_name, source)
				end
			else
				table.insert(clients_name, client.name)
			end
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

	local lsp_clients = get_all_attached_clients(buf_ft)
	local conform_clients = get_conform_clients(buf_ft)
	local nvimlint_clients = get_nvimlint_clients(buf_ft)

	local all_clients = {}

	safe_extend(all_clients, lsp_clients)
	safe_extend(all_clients, conform_clients)
	safe_extend(all_clients, nvimlint_clients)

	return table.concat(all_clients, ", ")
end

M.abbreviate_path = function()
	local p = vim.fn.expand("%:p")
	local path = string.gsub(p, vim.fn.expand("$HOME"), "")
	local parts = vim.split(path, "/")
	local fileName = table.remove(parts)
	local folderName = table.remove(parts)

	local result = "~/"

	for _, part in ipairs(parts) do
		if part ~= "" then
			result = result .. part:sub(1, 1) .. "/" -- Append the first letter and a slash
		end
	end

	return result .. folderName .. "/" .. fileName
end

M.rm_cwd_from_path = function()
	local path = vim.fn.expand("%:p")
	local cwd = vim.fn.getcwd()
	local removed = path:sub(#cwd + 2) -- Add 2 to account for the leading slash and the extra slash
	return removed
end

return M
