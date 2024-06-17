-- Keymap for organizing imports with gopls
vim.keymap.set("n", "<leader>ci", function()
  return vim.lsp.buf.code_action({
    filter = function(action)
      return action.title == "Organize Imports" -- Must match gopls title
    end,
    apply = true,                            -- Automatically apply the first matching code action
  })
end)
