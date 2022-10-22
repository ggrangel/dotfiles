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

local build_message = function(clients)
  local possibly_add_word_separator = function(msg)
    if msg ~= "" then
      msg = msg .. ", "
    end
    return msg
  end

  if clients == nil then
    return "none"
  end

  local msg = ""
  for _, client in ipairs(clients) do
    msg = possibly_add_word_separator(msg)
    msg = msg .. client
  end

  return msg
end

M.list_attached_lsp_clients = function()
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")

  local clients = get_all_attached_clients(buf_ft)

  return build_message(clients)
end

return M
