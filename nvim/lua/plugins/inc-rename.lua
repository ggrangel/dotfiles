vim.keymap.set("n", "<leader>rn", function()
  vim.api.nvim_feedkeys(":IncRename " .. vim.fn.expand("<cword>"), "n", false)
end, { expr = true })

require("inc_rename").setup()
