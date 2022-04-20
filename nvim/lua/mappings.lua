-- Modes
-- normal = n
-- insert = i
-- visual = v
-- visual_block = x
-- term = t
-- command = c
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true }

vim.g.mapleader = " "

-- Disable Ex mode
keymap("n", "Q", "<nop>", opts)

-- Nvim-tree
keymap("n", "<leader>t", ":NvimTreeToggle <CR>", opts)

---- Keeping it centered
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)

---- Undo breakpoints
keymap("i", ",", ",<c-g>u", opts)
keymap("i", ".", ".<c-g>u", opts)
keymap("i", "!", "!<c-g>u", opts)
keymap("i", "?", "?<c-g>u", opts)

---- Moving text
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

---- Yank whole buffer
keymap("n", "<leader>Y", "ggyG", opts)

---- Do not delete to register
keymap("n", "<leader>d", '"_d', opts)
keymap("n", "<leader>D", '"_D', opts)
keymap("v", "<leader>d", '"_d', opts)
keymap("v", "<leader>D", '"_D', opts)
keymap("n", "<leader>c", '"_c', opts)
keymap("n", "<leader>C", '"_C', opts)
keymap("v", "<leader>c", '"_c', opts)
keymap("v", "<leader>C", '"_C', opts)

---- Vertical resize
keymap("n", "<leader>+", ":vertical resize +10<CR>", opts)
keymap("n", "<leader>-", ":vertical resize -10<CR>", opts)
keymap("n", "<leader>=", "<C-w>=", opts)

---- Navigate tabs
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

--- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

---- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fi", ":Telescope git_files<CR>", opts)
keymap("n", "<leader>fn", ":lua require('telescope').extensions.neoclip.default()<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fb", ":Telescope bookmarks<CR>", opts)

--- Trouble
keymap("n", "<leader>xx", ":TroubleToggle <CR>", opts)
keymap("n", "gr", ":TroubleToggle lsp_references<CR>", opts)

keymap("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/luasnip-setup.lua<CR>", opts)

-- for tiny movements in insert mode
keymap("i", "<C-h>", "<Esc>i", opts)
keymap("i", "<C-l>", "<Esc>la", opts)
keymap("i", "<C-k>", "<Esc>ka", opts)
keymap("i", "<C-j>", "<Esc>ja", opts)

-- navigate between windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-j>", "<C-w>j", opts)

-- close other tab
keymap("n", "<C-q>h", "<C-w>h :q <CR>", opts)
keymap("n", "<C-q>l", "<C-w>l :q <CR>", opts)
keymap("n", "<C-q>k", "<C-w>k :q <CR>", opts)
keymap("n", "<C-q>j", "<C-w>j :q <CR>", opts)

-- duplicate line without yanking to clipboard
keymap("n", "<leader>p", '"zyy"zp', opts)

-- fix an weird behavior of cw
keymap("n", "cw", "dwi", opts)
keymap("n", "cW", "dWi", opts)

-- Mirrors vim-surround keybindings to vim-sandwich
vim.cmd([[
runtime macros/sandwich/keymap/surround.vim
]])

---- Refactoring nvim
-- Remaps for each of the four refactoring operations currently offered by the plugin
keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], opts)
keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], opts)
keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], opts)
keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opts)

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opts)
-- keymap("n", "<leader>rp", ":lua require('refactoring').debug.printf({below = true})<CR>", opts)

-- Print var: this remap should be made in visual mode
keymap("v", "<leader>rp", ":lua require('refactoring').debug.print_var({})<CR>", opts)

-- Cleanup function: this remap should be made in normal mode
keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", opts)

---- Harpoon
keymap("n", "<leader>hm", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>hh", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
for i = 1, 6 do
	keymap("n", "<leader>h" .. i .. "", ":lua require('harpoon.ui').nav_file(" .. i .. ")<CR>", opts)
end

--- Vim-rails
keymap("n", "<leader>em", ":Emodel<CR>", opts)
keymap("n", "<leader>ev", ":Eview<CR>", opts)
keymap("n", "<leader>ec", ":Econtroller<CR>", opts)
