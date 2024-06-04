require("mason").setup()
local lspconfig = require("lspconfig")

local handlers = {}

handlers.on_attach = function(client, bufnr)
  -- highlights other uses of the word under cursor using LSP and treesitter
  require("illuminate").on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")

handlers.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
handlers.capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
  "bashls",
  "eslint",
  "lua_ls",
  "pyright",
  "tailwindcss",
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  local has_custom_opts, server_custom_opts = pcall(require, "plugins/lsp/settings/" .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end

  lspconfig[server].setup(opts)
end

require("mason-lspconfig").setup({
  ensure_installed = servers,
})

-- press this key twice in order to focus on the diagnostic window
-- useful for yanking the text
vim.keymap.set("n", "gl", function()
  return vim.diagnostic.open_float({ border = "rounded" })
end)

vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<space>gt", vim.lsp.buf.type_definition)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- nvim lsp defaults:
-- vim.keymap.set("n", "[d", function()
--   return vim.diagnostic.goto_prev({ border = "rounded" })
-- end)
-- vim.keymap.set("n", "]d", function()
--   return vim.diagnostic.goto_next({ border = "rounded" })
-- end)
-- vim.keymap.set("n", "K", vim.lsp.buf.hover)

require("typescript-tools").setup({
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
    -- "remove_unused_imports"|"organize_imports") -- or string "all"
    -- to include all supported code actions
    -- specify commands exposed as code_actions
    expose_as_code_action = "all",
    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
    -- not exists then standard path resolution strategy is applied
    tsserver_path = nil,
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    -- locale of all tsserver messages, supported locales you can find here:
    -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
    tsserver_locale = "en",
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    -- CodeLens
    -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
    -- possible values: ("off"|"all"|"implementations_only"|"references_only")
    code_lens = "off",
    -- by default code lenses are displayed on all referencable values and for some of you it can
    -- be too much this option reduce count of them by removing member references from lenses
    disable_member_code_lens = true,
    -- JSXCloseTag
    -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
    -- that maybe have a conflict if enable this feature. )
    jsx_close_tag = {
      enable = false,
      filetypes = { "javascriptreact", "typescriptreact" },
    },
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("TS_add_missing_imports", { clear = true }),
  desc = "TS_add_missing_imports",
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    vim.cmd([[TSToolsAddMissingImports]])
    vim.cmd("write")
  end,
})
