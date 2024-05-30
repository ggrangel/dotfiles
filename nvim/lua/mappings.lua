local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("n", "<leader>A", ":wa | lua vim.notify('Project saved') <CR>")
keymap("n", "<leader>S", ":wa | source | lua vim.notify('Config sourced') <CR>", { silent = true })
keymap("n", "<leader>N", ":Nredir Notifications <CR>") -- opens notification in new window
vim.cmd([[let g:winresizer_start_key = '<leader>W']])  --> window resize

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

---- Navigate tabs
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
-- keymap("n", "<C-k>", "<C-w>k")
-- keymap("n", "<C-l>", "<C-w>l")

--- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- close other tab
keymap("n", "<C-q>h", "<C-w>h :q <CR>")
keymap("n", "<C-q>l", "<C-w>l :q <CR>")
keymap("n", "<C-q>k", "<C-w>k :q <CR>")
keymap("n", "<C-q>j", "<C-w>j :q <CR>")
