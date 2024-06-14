require("other-nvim").setup({
  mappings = {
    "golang",
  },
})

vim.keymap.set("n", ":A<CR>", "<cmd>:Other<CR>")
