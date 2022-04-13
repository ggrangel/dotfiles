local g = vim.g

-- g.startify_custom_header = {
-- '',
-- '',
-- '                                       ██            ',
-- '                                      ░░             ',
-- '    ███████   █████   ██████  ██    ██ ██ ██████████ ',
-- '   ░░██░░░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██',
-- '    ░██  ░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██',
-- '    ░██  ░██░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██',
-- '    ███  ░██░░██████░░██████   ░░██   ░██ ███ ░██ ░██',
-- '   ░░░   ░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░ ',
-- '',
-- '',
-- }
g.webdevicons_enable_startify = 1
g.startify_enable_special = 0
g.startify_session_autoload = 1
g.startify_session_delete_buffers = 1
g.startify_change_to_vcs_root = 1
g.startify_fortune_use_unicode = 1
g.startify_session_persistence = 1
g.startfiy_change_to_dir = 0

vim.cmd([[ let g:startify_custom_indices = map(range(1,100), 'string(v:val)') ]])

--[[ -- Custom Header
----------------
local cwd = vim.fn.split(vim.fn.getcwd(), '/')
local banner = vim.fn.system("figlet -f 3d "..cwd[#cwd])
local header = vim.fn['startify#pad'](vim.fn.split(banner, '\n'))
vim.g.startify_custom_header = header ]]

g.startify_lists = {
	{ type = "dir", header = { "   Current Directory " .. vim.fn.getcwd() .. ":" } },
	{ type = "bookmarks", header = { "   Bookmarks" } },
}

g.startify_bookmarks = {
	{ al = "~/.config/zsh/aliasrc" },
	{ au = "~/.config/misc/autostart.sh" },
	{ dms = "~/scripts/dmscripts/" },
	{ ha = "~/scripts/heyarco.sh" },
	{ nv = "~/.config/nvim/init.lua" },
	{ st = "~/.config/nvim/lua/startify-setup.lua" },
	{ sx = "~/.config/sxhkd/sxhkdrc" },
	{ ti = "~/.config/qtile/config.py" },
	{ zsh = "~/.config/zsh/" },
}
