return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "use", "awesome", "client", "screen", "root" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}
