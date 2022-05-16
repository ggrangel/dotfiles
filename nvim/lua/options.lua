vim.opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor.
vim.opt.wrap = false -- do not wrap long text
vim.opt.clipboard = "unnamedplus" -- from yank to clipboard and vice versa
-- vim.opt.updatetime = 300 -- default is 4000ms
vim.opt.splitright = true
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

-- set this to false when running macros with find (/) words
vim.opt.wrapscan = true

------ Numbering
vim.opt.relativenumber = true
vim.opt.number = true

------ Searching
vim.opt.hlsearch = false -- do not highlight search pattern
vim.opt.incsearch = true -- gradually show matched pattern

------ Indenting
vim.opt.tabstop = 4 -- number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

------ Smart-diacritic search
vim.opt.smartcase = true
vim.opt.ignorecase = true

------ Manage files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

------ Appearance
vim.cmd([[
try
  colorscheme darkplus
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
-- vim.opt.termguicolors = true -- for colorizer to work

------ Treesitter
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldenable = false

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
