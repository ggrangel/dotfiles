-- Necessary for accessing lua files (with 'gf') without having to type the .lua extension
vim.opt_local.suffixesadd:prepend("lua")
vim.opt_local.suffixesadd:prepend("init.lua")
vim.opt_local.path:prepend(vim.fn.stdpath("config") .. "/lua")
