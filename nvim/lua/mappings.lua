-- Modes
-- normal = n
-- insert = i
-- visual = v
-- visual_block = x
-- term = t
-- command = c
local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("n", "<leader>A", ":wa | lua vim.notify('Project saved') <CR>")
keymap("n", "<leader>S", ":wa | source | lua vim.notify('Config sourced') <CR>", { silent = true })
keymap("n", "<leader>N", ":Nredir Notifications <CR>") -- opens notification in new window
vim.cmd([[let g:winresizer_start_key = '<leader>W']]) --> window resize

-- Nvim-tree
keymap("n", "<leader>t", ":NvimTreeToggle <CR>")

--> LuaSnip <--
vim.api.nvim_create_user_command("LuaSnipEdit", require("luasnip.loaders.from_lua").edit_snippet_files, {})
keymap("n", "<leader><CR>", "<cmd>LuaSnipEdit<cr>")
keymap(
  "n",
  "<leader>L",
  ":source ~/.config/nvim/lua/plugins/luasnip-setup.lua | lua vim.notify('Luasnip sourced') <CR>"
)

-- Lualine
keymap("n", "<leader>ls", function()
  local lualine = require("lualine")
  if vim.o.ls == 0 then
    lualine.hide({ unhide = true })
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
vim.cmd([[
runtime macros/sandwich/keymap/surround.vim
]])

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
  return vim.diagnostic.goto_prev({ border = "rounded" })
end)
keymap("n", "]d", function()
  return vim.diagnostic.goto_next({ border = "rounded" })
end)
keymap("n", "gl", function()
  return vim.diagnostic.open_float({ border = "rounded" })
end)

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

keymap("v", "<leader>al", function()
  require("align").align_to_char(1)
end) -- Align to chosen character

--- yanky.nvim
keymap({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
keymap({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
keymap({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
keymap({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
keymap("n", "<c-n>", "<Plug>(YankyCycleForward)")
keymap("n", "<c-p>", "<Plug>(YankyCycleBackward)")
