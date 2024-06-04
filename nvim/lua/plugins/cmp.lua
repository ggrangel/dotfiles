local cmp = require("cmp")
local ls = require("luasnip")
local lspkind = require("lspkind")
lspkind.init()

require("luasnip/loaders/from_vscode").lazy_load()
require("vim-react-snippets").lazy_load()

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = "text",
      menu = {
        nvim_lsp = "[LSP]",
        nvim_lua = "[NV-LUA]",
        luasnip = "[Snip]",
        buffer = "[Buff]",
        path = "[Path]",
      },
    }),
  },
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "nvim_lua" }, -- lua nvim API
    { name = "buffer",  max_item_count = 5, keyword_length = 5 },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ["<C-,>"] = cmp.mapping.complete(),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      { "i", "c" }
    ),
  },

  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end,
  },
})

-- Ctrl + K and Ctrl + J to jump around snippet nodes
vim.snippet.expand = ls.lsp_expand

-- ---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.active = function(filter)
  filter = filter or {}
  filter.direction = filter.direction or 1

  if filter.direction == 1 then
    return ls.expand_or_jumpable()
  else
    return ls.jumpable(filter.direction)
  end
end

-- ---@diagnostic disable-next-line: duplicate-set-field
vim.snippet.jump = function(direction)
  if direction == 1 then
    if ls.expandable() then
      return ls.expand_or_jump()
    else
      return ls.jumpable(1) and ls.jump(1)
    end
  else
    return ls.jumpable(-1) and ls.jump(-1)
  end
end

vim.snippet.stop = ls.unlink_current

ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  override_builtin = true,
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
  loadfile(ft_path)()
end

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
end, { silent = true })
