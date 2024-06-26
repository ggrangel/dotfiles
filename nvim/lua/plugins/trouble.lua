require("trouble").setup({
  modes = {
    symbols = {
      win = { position = "bottom" },
    },
  },
})

--- Trouble
vim.keymap.set("n", "<leader>xx", ":Trouble diagnostics toggle focus=true <CR>")
vim.keymap.set("n", "<leader>xX", ":Trouble diagnostics toggle filter.buf=0 focus=true <CR>")
vim.keymap.set("n", "<leader>xl", ":Trouble symbols toggle focus=false <CR>")
vim.keymap.set("n", "gr", ":Trouble lsp toggle focus=true <CR>")
