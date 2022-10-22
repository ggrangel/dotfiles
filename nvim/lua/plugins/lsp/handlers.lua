local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  -- Defining signs
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- show error in virtual text (right side)
    virtual_text = false,
    -- show signs
    signs = { active = signs },
    -- update errors in insert mode
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    -- window that shows when we press gl
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  -- appeareance of the box when we press K
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

  -- appereance of the signature box (?)
  vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
end

local function lsp_highlight_document(client)
  require("illuminate").on_attach(client)
end

M.on_attach = function(client, bufnr)
  -- tsserver already has a builtin format. Let's disable it so it does not collide with prettier.
  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
  end

  lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp = require("cmp_nvim_lsp")

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

return M
