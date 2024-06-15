require("harpoon").setup({
  global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,

    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,

    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = true,

    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,

    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { "harpoon" },

    -- set marks specific to each git branch inside git repository
    mark_branch = false,
  },
})

local keymap = vim.keymap.set
local harpoon_ui = require("harpoon.ui")
local harpoon_tmux = require("harpoon.tmux")

keymap("n", "<leader>hr", function()
  return require("harpoon.mark").add_file()
end)
keymap("n", "<leader>hh", function()
  return harpoon_ui.toggle_quick_menu()
end)
local hkeys = { "a", "s", "d", "f", "g" }
for i = 1, 5 do
  keymap("n", "<leader>h" .. hkeys[i], function()
    return harpoon_ui.nav_file(i)
  end)
end

keymap("n", "<leader>hl", function()
  return require("harpoon.cmd-ui").toggle_quick_menu()
end)

local function goto_tmux_pane(name)
  local cmd = string.format("tmux select-window -t %s", name)
  vim.fn.jobstart(cmd, { detach = true })
end

hkeys = { "q", "w", "e", "r", "t" }
for i = 1, 5 do
  keymap("n", "<leader>h" .. hkeys[i], function()
    -- for some reason harpoon.tmux.gotoTerminal is not working
    goto_tmux_pane("term")
    harpoon_tmux.sendCommand("term", 1)
  end)
end
