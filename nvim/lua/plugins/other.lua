require("other-nvim").setup({
  mappings = {
    "golang",
  },
})

vim.api.nvim_create_user_command("A", "Other", {})
