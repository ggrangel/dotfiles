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
			-- https://stackoverflow.com/questions/44353597/awesome-wm-some-clients-pop-up-floating-and-vertically-and-horizontally-maximiz
			-- Future GUSTAVO: whenever you accidentally maximize/minimize brave or other GUI app
			-- uncomment the following lines and restart awesome to fix a glitch.
			-- maximized_vertical = false,
			-- maximized_horizontal = false,
			-- floating = false,
			maximized = false,
		},
	},

	-- { rule = { instance = "brave-browser" }, properties = { screen = screen[1], tag = "1" } },
	{ rule = { instance = "telegram-desktop" }, properties = { screen = screen[3], tag = "4" } },
	{ rule = { instance = "whatsapp-nativefier-d40211" }, properties = { screen = screen[3], tag = "4" } },
	{ rule = { instance = "Insync" }, properties = { screen = screen[3], tag = "4" } },
}

return rules
