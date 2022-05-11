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

keymap("n", "<leader><leader>s", ":source $MYVIMRC<CR>", opts)

-- Disable Ex mode
keymap("n", "Q", "<nop>", opts)

-- Nvim-tree
keymap("n", "<leader>t", ":NvimTreeToggle <CR>", opts)
-- window resize
vim.cmd([[let g:winresizer_start_key = '<leader>w']])

---- Keeping it centered
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)

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
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
-- keymap("n", "<leader>fn", ":lua require('telescope').extensions.neoclip.default()<CR>", opts)
-- keymap("n", "<leader>fb", ":Telescope bookmarks<CR>", opts)

--- Trouble
keymap("n", "<leader>xx", ":TroubleToggle <CR>", opts)
keymap("n", "gr", ":TroubleToggle lsp_references<CR>", opts)

-- close other tab
keymap("n", "<C-q>h", "<C-w>h :q <CR>", opts)
keymap("n", "<C-q>l", "<C-w>l :q <CR>", opts)
keymap("n", "<C-q>k", "<C-w>k :q <CR>", opts)
keymap("n", "<C-q>j", "<C-w>j :q <CR>", opts)

-- Mirrors vim-surround keybindings to vim-sandwich
vim.cmd([[
runtime macros/sandwich/keymap/surround.vim
]])

---- Refactoring nvim
-- Remaps for each of the four refactoring operations currently offered by the plugin
-- keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], opts)
-- keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], opts)
-- keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], opts)
-- keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opts)
-- -- Inline variable can also pick up the identifier currently under the cursor without visual mode
-- keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opts)
-- -- keymap("n", "<leader>rp", ":lua require('refactoring').debug.printf({below = true})<CR>", opts)
-- -- Print var: this remap should be made in visual mode
-- keymap("v", "<leader>rp", ":lua require('refactoring').debug.print_var({})<CR>", opts)
-- -- Cleanup function: this remap should be made in normal mode
-- keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", opts)

---- Harpoon
keymap("n", "<leader>hf", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>hh", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
local hkeys = { "a", "s", "d", "f", "g" }
for i = 1, 5 do
	keymap("n", "<leader>h" .. hkeys[i] .. "", ":lua require('harpoon.ui').nav_file(" .. i .. ")<CR>", opts)
end

--- Vim-rails
keymap("n", "<leader>rm", ":Emodel<CR>", opts)
keymap("n", "<leader>rv", ":Eview<CR>", opts)
keymap("n", "<leader>rc", ":Econtroller<CR>", opts)
