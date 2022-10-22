local lualine = require "lualine"

-- stylua: ignore
local colors = {
  bg       = '#282A36',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand "%:t") ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand "%:p:h"
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
    disabled_filetypes = { "NvimTree" },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  "branch",
  color = { fg = colors.violet, gui = "bold" },
}

ins_left {
  "diff",
  -- Is it me or the symbol for modified us really weird
  symbols = { added = " ", modified = "柳", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_left {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert new section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return "%="
  end,
}

ins_left {
  "%{expand('%:p:h:t')}/%t",
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = "bold" },
}

ins_right {
  "filetype",
  color = { fg = colors.green, gui = "bold" },
}

local does_table_contain_element = function(table, element)
  for _, value in ipairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

local null_ls = require "null-ls"

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
  for _, server in ipairs(clients) do
    msg = possibly_add_word_separator(msg)
    msg = msg .. server
  end

  return msg
end

ins_right {
  function()
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")

    local clients = get_all_attached_clients(buf_ft)

    local msg = build_message(clients)

    return msg
  end,
  icon = " servers:",
  color = { fg = colors.violet, gui = "bold" },
}

ins_right { "progress", color = { fg = colors.orange, gui = "bold" } }

lualine.setup(config)
-- lualine.hide() -- hidden by default
