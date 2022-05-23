local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local modkey = "Mod4"
-- local terminal = os.getenv("TERMINAL")

local screens_kb = { "u", "i", "o" }
local tags_kb = { "n", "m", ",", ".", "/" }

local keybindings = {}

keybindings.globalkeys = gears.table.join(
	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	-- Windows movements
	awful.key({ modkey }, "j", function()
		awful.client.focus.bydirection("down")
	end, { description = "focus lower window", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.bydirection("up")
	end, { description = "focus upper window", group = "client" }),
	awful.key({ modkey }, "h", function()
		awful.client.focus.bydirection("left")
	end, { description = "focus left window", group = "client" }),
	awful.key({ modkey }, "l", function()
		awful.client.focus.bydirection("right")
	end, { description = "focus right window", group = "client" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.global_bydirection("down")
	end, { description = "swap with lower client", group = "layout" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.global_bydirection("up")
	end, { description = "swap with upper client", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.client.swap.global_bydirection("left")
	end, { description = "swap with left client", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.client.swap.global_bydirection("right")
	end, { description = "swap with right client", group = "layout" }),

	-- Float window
	awful.key(
		{ modkey, "Control" },
		"space",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),

	-- Resizing
	awful.key({ modkey, "Control" }, "j", function()
		awful.client.incwfact(0.01)
	end, { description = "increase/decrease vertical size", group = "layout" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.client.incwfact(-0.01)
	end, { description = "increase/decrease vertical size", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incmwfact(-0.01)
	end, { description = "increase/decrease horizontal size", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incmwfact(0.01)
	end, { description = "increase/decrease horizontal size", group = "layout" }),
	-- If you ever change your x-axis resolution (1920px), you have to update the setmwfact() argument values.
	awful.key({ modkey, "Control" }, "1", function()
		awful.tag.setmwfact(0.29)
	end, { description = "set horizontal size in the xs range (<576 px)", group = "test" }),
	awful.key({ modkey, "Control" }, "2", function()
		awful.tag.setmwfact(0.35)
	end, { description = "set horizontal size in the sm range (>=576 px)", group = "test" }),
	awful.key({ modkey, "Control" }, "3", function()
		awful.tag.setmwfact(0.50)
	end, { description = "set horizontal size in the md range (>= 768 px)", group = "test" }),
	awful.key({ modkey, "Control" }, "4", function()
		awful.tag.setmwfact(0.60)
	end, { description = "set horizontal size in the lg range (>= 992 px)", group = "test" }),
	awful.key({ modkey, "Control" }, "5", function()
		awful.tag.setmwfact(0.70)
	end, { description = "set horizontal size in the xl range (>= 1200 px)", group = "test" }),
	awful.key({ modkey, "Control" }, "6", function()
		awful.tag.setmwfact(0.80)
	end, { description = "set horizontal size in the xl range (>= 1400 px)", group = "test" }),

	-- Screen movements
	awful.key({ modkey }, screens_kb[1], function()
		awful.screen.focus(1)
	end, { description = "focus screen 1", group = "screen" }),
	awful.key({ modkey }, screens_kb[2], function()
		awful.screen.focus(2)
	end, { description = "focus screen 2", group = "screen" }),
	awful.key({ modkey }, screens_kb[3], function()
		awful.screen.focus(3)
	end, { description = "focus screen 3", group = "screen" })
)

keybindings.clientkeys = gears.table.join(
	-- awful.key({ modkey }, "\\", function(c)
	-- 	c:kill()
	-- end, { description = "close client", group = "client" }),

	-- Client movements
	awful.key({ modkey, "Shift" }, screens_kb[1], function(c)
		c:move_to_screen(1)
	end, { description = "move client to screen 1", group = "client" }),
	awful.key({ modkey, "Shift" }, screens_kb[2], function(c)
		c:move_to_screen(2)
	end, { description = "move client to screen 2", group = "client" }),
	awful.key({ modkey, "Shift" }, screens_kb[3], function(c)
		c:move_to_screen(3)
	end, { description = "move client to screen 3", group = "client" })
)

-- Bind key numbers to tags.
for j = 1, #tags_kb do
	local tag = tags_kb[j]

	keybindings.globalkeys = gears.table.join(
		keybindings.globalkeys,

		awful.key({ modkey }, tag, function()
			local screen = awful.screen.focused()
			local screenTag = screen.tags[j]
			if screenTag then
				screenTag:view_only()
			end
		end, { description = "view tag #" .. j, group = "tag" }),

		awful.key({ modkey, "Shift" }, tag, function()
			if client.focus then
				local focusedTag = client.focus.screen.tags[j]
				if focusedTag then
					client.focus:move_to_tag(focusedTag)
					focusedTag:view_only()
				end
			end
		end, { description = "move focused client to tag #" .. j .. " and view it", group = "tag" })
	)
end

keybindings.clientbuttons = gears.table.join(
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

return keybindings
