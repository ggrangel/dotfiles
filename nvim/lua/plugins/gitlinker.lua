require("gitlinker").setup()
vim.keymap.set(
  "n",
  "<leader>gb",
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
)
vim.keymap.set(
  "v",
  "<leader>gb",
  '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
)
