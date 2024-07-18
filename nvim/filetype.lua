vim.filetype.add({
  filename = {
    [".*/workflows/.*yaml"] = "ghactions",
    [".*/workflows/.*yml"] = "ghactions",
  },
})
