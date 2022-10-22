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

  ------ Bar Heights
  ls = 0, -- last stats
  ch = 0, -- command height

  ------ Searching
  hlsearch = false, -- do not highlight search pattern
  incsearch = true, -- gradually show matched pattern

  ------ Indenting
  tabstop = 2, -- number of spaces that a <Tab> in the file counts for
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,

  ------ Smart-diacritic search
  smartcase = true,
  ignorecase = true,

  ------ Disable mouse
  mouse = "",

  ------ Manage files
  swapfile = false,
  backup = false,
  undofile = true, -- enables persistent undo

  guifont = "monospace:h17", -- the font used in graphical neovim applications
  termguicolors = true, -- for opacity changes

  -- shadafile = "NONE", -- improves startuptime a little bit
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Treesitter folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldenable = false

vim.api.nvim_create_augroup("one_time_opts", { clear = true })
-- opens help in left window
vim.api.nvim_create_autocmd("FileType", { pattern = "help", command = "wincmd L", group = "one_time_opts" })
-- disables continuation of comments (doesn't work to set as an option)
vim.api.nvim_create_autocmd("BufEnter", { command = "set formatoptions-=cro", group = "one_time_opts" })
vim.api.nvim_create_autocmd("BufEnter", { command = "setlocal formatoptions-=cro", group = "one_time_opts" })
