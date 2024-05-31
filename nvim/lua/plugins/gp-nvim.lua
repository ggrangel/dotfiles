require("gp").setup({
  openai_api_key = os.getenv("OPENAI_API_KEY"),
})

local function keymapOptions(desc)
  return {
    noremap = true,
    silent = true,
    nowait = true,
    desc = "GPT prompt " .. desc,
  }
end

vim.keymap.set({ "n" }, "<leader>ut", ":GpChatToggle vsplit<cr>", keymapOptions("New Chat"))
vim.keymap.set({ "v" }, "<leader>up", ":GpChatPaste vsplit<cr>", keymapOptions("New Chat"))
vim.keymap.set({ "n" }, "<leader>uf", ":GpChatFinder <cr>", keymapOptions("New Chat"))
