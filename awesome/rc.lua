-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local awful = require("awful")
local keybindings = require("setup/keybindings")
local naughty = require("naughty") -- Notification library
local rules = require("setup/rules")

require("awful.autofocus") -- Handles transfer of focus when the previously focused windows disappeared
require("setup/screens")
require("setup/signals")

-- Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end

-- this must go first to give priority to sxhkd's keybdings
awful.spawn.with_shell("/home/rangelgbr/scripts/autostart.sh")

root.keys(keybindings.globalkeys)

awful.rules.rules = rules
