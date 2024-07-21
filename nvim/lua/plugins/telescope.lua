local telescope = require("telescope")

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    preview = false,
    layout_config = {
      height = 0.5,
      width = 0.5,
    },
    shorten_path = true,
    sorting_strategy = "ascending",

    --- Default mappings
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,

        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        ["?"] = actions.which_key,
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
      },
    },
  },
  pickers = {
    help_tags = {
      preview = true,
      layout_config = {
        height = 0.8,
        width = 0.8,
      },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,      -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {},
})

telescope.load_extension("fzf")
telescope.load_extension("frecency")

local builtin = require("telescope.builtin")
local setPreview = {
  preview = true,
  layout_config = {
    height = 0.75,
    width = 0.75,
  },
}

vim.keymap.set("n", "<leader>f/", function()
  return builtin.current_buffer_fuzzy_find()
end, { desc = "Fuzzy find in current buffer" })
vim.keymap.set("n", "<leader>fa", function()
  return telescope.extensions.frecency.frecency()
end, { desc = "Find all files" })
-- vim.keymap.set("n", "<leader>fa", function()
--   return builtin.find_files()
-- end, { desc = "Find all files" })
vim.keymap.set("n", "<leader>fd", function()
  return builtin.diagnostics(setPreview)
end, { desc = "Show LSP diagnostics" })
vim.keymap.set("n", "<leader>ff", function()
  return builtin.resume()
end, { desc = "Resume last picker" })
vim.keymap.set("n", "<leader>fh", function()
  return builtin.help_tags()
end, { desc = "Show nvim help tags" })
-- vim.keymap.set("n", "<leader>fi", function()
--   return builtin.git_files()
-- end, { desc = "Find git files" })
vim.keymap.set("n", "<leader>fj", function()
  return builtin.buffers()
end, { desc = "Show buffers" })
vim.keymap.set("n", "<leader>fk", function()
  return builtin.keymaps()
end, { desc = "Show keymaps" })
vim.keymap.set("n", "<leader>fl", function()
  return builtin.live_grep(setPreview)
end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fm", function()
  return builtin.marks(setPreview)
end, { desc = "Show marks" })
vim.keymap.set("n", "<leader>fr", function()
  return builtin.registers()
end, { desc = "Show registers" })
vim.keymap.set("n", "<leader>fs", function()
  return builtin.spell_suggest()
end, { desc = "Show spell suggestions" })
vim.keymap.set("n", "<leader>fu", function()
  return builtin.jumplist(setPreview)
end, { desc = "Show jumplist" })
vim.keymap.set("n", "<leader>fy", function()
  return builtin.command_history()
end, { desc = "Show command history" })
