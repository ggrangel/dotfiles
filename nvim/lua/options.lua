local options = {
	scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
	wrap = false, -- do not wrap long text
	clipboard = "unnamedplus", -- from yank to clipboard and vice versa
	splitright = true, -- split vertical window to the right of the current window
	completeopt = { "menuone", "noinsert", "noselect" }, -- for cmp to work fine
	updatetime = 300, -- faster completion. default is 4000ms
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time

	-- set this to false when running macros with find (/) words
	wrapscan = true,

	------ Numbering
	relativenumber = true,
	number = true,

	------ Searching
	hlsearch = false, -- do not highlight search pattern
	incsearch = true, -- gradually show matched pattern

	------ Indenting
	tabstop = 4, -- number of spaces that a <Tab> in the file counts for
	softtabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	smartindent = true,

	------ Smart-diacritic search
	smartcase = true,
	ignorecase = true,

	------ Manage files
	swapfile = false,
	backup = false,
	undofile = true, -- enables persistent undo

	guifont = "monospace:h17", -- the font used in graphical neovim applications
	-- termguicolors = true -- for colorizer to work
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

------ Treesitter
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldenable = false

------ Appearance
vim.cmd([[
try
  colorscheme darkplus
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]])

-- open help in vertical split
vim.cmd([[
autocmd FileType help wincmd L
]])

-- Disable continuation of comments in new line
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")
