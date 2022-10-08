-- Modes
-- normal = n
-- insert = i
-- visual = v
-- visual_block = x
-- term = t
-- command = c
local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("n", "<leader><leader>a", ":wa | lua vim.notify('Project saved') <CR>")
-- keymap("n", "<leader><leader>s", ":wa | source | lua vim.notify('Project sourced') <CR>", { silent = true })
keymap(
  "n",
  "<leader><leader>s",
  ":source ~/.config/nvim/lua/plugins/luasnip-setup.lua | lua vim.notify('Luasnip sourced') <CR>"
)

vim.cmd [[let g:winresizer_start_key = '<Space>w']] --> window resize

-- Nvim-tree
keymap("n", "<leader>t", ":NvimTreeToggle <CR>")

-- Lualine
keymap("n", "<leader>ls", function()
  local lualine = require "lualine"
  if vim.o.ls == 0 then
    lualine.hide { unhide = true }
  else
    lualine.hide()
  end
end)

-- Show command status: useful when you're recording a query
keymap("n", "<leader>ch", function()
  if vim.o.ch == 0 then
    vim.o.ch = 1
  else
    vim.o.ch = 0
  end
end)

-- Mirrors vim-surround keybindings to vim-sandwich

--> ys, yss, yS, ds, cs, S, dss, css
vim.cmd [[
runtime macros/sandwich/keymap/surround.vim
]]

---- Keeping it centered
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "J", "mzJ`z")

---- Paste from 0 register
keymap({ "n", "v" }, "<leader>p", '"0p')

---- Navigate tabs
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

--- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

---- Telescope
keymap("n", "<leader>ff", function()
  return require("telescope.builtin").find_files()
end)
keymap("n", "<leader>fl", function()
  return require("telescope.builtin").live_grep()
end)
keymap("n", "<leader>fi", function()
  return require("telescope.builtin").git_files()
end)
keymap("n", "<leader>fb", function()
  return require("telescope.builtin").buffers()
end)
keymap("n", "<leader>fh", function()
  return require("telescope.builtin").help_tags()
end)

--- Trouble
keymap("n", "<leader>xd", ":Trouble workspace_diagnostics <CR>")
keymap("n", "<leader>xx", ":TroubleToggle <CR>")
keymap("n", "gr", ":TroubleToggle lsp_references<CR>")

-- close other tab
keymap("n", "<C-q>h", "<C-w>h :q <CR>")
keymap("n", "<C-q>l", "<C-w>l :q <CR>")
keymap("n", "<C-q>k", "<C-w>k :q <CR>")
keymap("n", "<C-q>j", "<C-w>j :q <CR>")

--- Vim-rails
keymap("n", "<leader>rm", ":Emodel<CR>")
keymap("n", "<leader>rv", ":Eview<CR>")
keymap("n", "<leader>rc", ":Econtroller<CR>")

--> LSP <--
keymap("n", "gD", vim.lsp.buf.declaration)
keymap("n", "gd", vim.lsp.buf.definition)
keymap("n", "K", vim.lsp.buf.hover)
keymap("n", "gi", vim.lsp.buf.implementation)
keymap("n", "<C-k>", vim.lsp.buf.signature_help)
keymap("n", "<space>gt", vim.lsp.buf.type_definition)
-- keymap("n", "gr", vim.lsp.buf.references) -- handled by trouble.nvim
keymap("n", "<leader>ca", vim.lsp.buf.code_action)
keymap("n", "[d", function()
  return vim.diagnostic.goto_prev { border = "rounded" }
end)
keymap("n", "]d", function()
  return vim.diagnostic.goto_next { border = "rounded" }
end)
keymap("n", "gl", function()
  return vim.diagnostic.open_float { border = "rounded" }
end)

--> LuaSnip <--
--vim.api.nvim_create_user_command("LuaSnipEdit", require("luasnip.loaders.from_lua").edit_snippet_files, {})
keymap("n", "<leader><CR>", "<cmd>LuaSnipEdit<cr>")

-- Harpoon
keymap("n", "<leader>hr", function()
  return require("harpoon.mark").add_file()
end)
keymap("n", "<leader>hh", function()
  return require("harpoon.ui").toggle_quick_menu()
end)
local hkeys = { "a", "s", "d", "f", "g" }
for i = 1, 5 do
  keymap("n", "<leader>h" .. hkeys[i], function()
    return require("harpoon.ui").nav_file(i)
  end)
end

---- Refactoring nvim
-- Remaps for each of the four refactoring operations currently offered by the plugin
-- keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]])
-- keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]])
-- keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]])
-- keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
-- -- Inline variable can also pick up the identifier currently under the cursor without visual mode
-- keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]])
-- -- keymap("n", "<leader>rp", ":lua require('refactoring').debug.printf({below = true})<CR>")
-- -- Print var: this remap should be made in visual mode
-- keymap("v", "<leader>rp", ":lua require('refactoring').debug.print_var({})<CR>")
-- -- Cleanup function: this remap should be made in normal mode
-- keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>")

local NS = { noremap = true, silent = true }

vim.keymap.set("v", "al", function()
  require("align").align_to_char(1)
end, NS) -- Align to chosen character
