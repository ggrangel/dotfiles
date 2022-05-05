local theme = require("setup/theme")
local awful = require("awful")
local keybindings = require("setup/keybindings")

-- Rules to apply to new clients (through the "manage" signal).
local rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = theme.border_width,
			border_color = theme.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = keybindings.clientkeys,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			maximized = false,
		},
	},

	-- { rule = { instance = "brave-browser" }, properties = { screen = screen[1], tag = "1" } },
	{ rule = { instance = "telegram-desktop" }, properties = { tag = "4" } },
	{ rule = { instance = "whatsapp-nativefier-d40211" }, properties = { tag = "4" } },
	{ rule = { instance = "Insync" }, properties = { tag = "4" } },
}

return rules
