local keymap = vim.keymap.set

vim.g.mapleader = " "

keymap("n", "<leader>A", ":wa | lua vim.notify('Project saved') <CR>")
keymap("n", "<leader>S", ":wa | source | lua vim.notify('Config sourced') <CR>", { silent = true })

-- Show command status: useful when you're recording a query
keymap("n", "<leader>ch", function()
  if vim.o.ch == 0 then
    vim.o.ch = 1
  else
    vim.o.ch = 0
  end
end, { desc = "Toggle command height" })

--- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- close other tab
keymap("n", "<C-q>h", "<C-w>h :bd <CR>")
keymap("n", "<C-q>l", "<C-w>l :bd <CR>")
keymap("n", "<C-q>k", "<C-w>k :bd <CR>")
keymap("n", "<C-q>j", "<C-w>j :bd <CR>")

-- quickly execute macro stored in 'q'
keymap("n", "Q", "@q", { desc = "Execute macro stored in 'q'" })
