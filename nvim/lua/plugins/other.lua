require("other-nvim").setup({
  mappings = {
    "golang",
  },
})

vim.api.nvim_create_user_command("A", "Other", {})
vim.api.nvim_create_user_command("AT", function()
  vim.cmd("wa")
  vim.cmd("Other")
  vim.cmd("TestNearest")
end, {})
