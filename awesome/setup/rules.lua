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

  -- run $ xprop to get an app's instance name
  { rule = { instance = "telegram-desktop" }, properties = { screen = screen[3], tag = "4" } },
}

-- Not sure what Navigator is anymore. Will leave it here, removing later if not needed
-- table.insert(rules, { rule = { instance = "Navigator" }, properties = { screen = screen[1], tag = "1" } })

return rules
