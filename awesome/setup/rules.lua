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

  { rule = { instance = "Insync" }, properties = { screen = screen[1], tag = "4" } },
}

local file = io.open("/etc/hostname")
if file ~= nil then
  local host_name = file:read()

  if host_name == "core" then
    table.insert(
      rules,
      { rule = { instance = "telegram-desktop" }, properties = { screen = screen[3], tag = "4" } }
    )
  elseif host_name == "aux" then
    table.insert(rules, { rule = { instance = "telegram-desktop" }, properties = { tag = "4" } })
    table.insert(rules, { rule = { instance = "brave-browser" }, properties = { tag = "2" } })
  end
end
return rules
