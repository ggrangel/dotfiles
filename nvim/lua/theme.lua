-- vim.cmd([[
-- try
--   colorscheme darkplus
-- catch /^Vim\%((\a\+)\)\=:E185/
--   colorscheme default
--   set background=dark
-- endtry
-- ]])

vim.g.catppuccin_flavour = "macchiato" -- macchiato, mocha, dusk
vim.cmd [[colorscheme catppuccin]]
