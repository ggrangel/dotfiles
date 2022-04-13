local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
}

-- awful.tag({ "1" }, screen[1], layouts[2])
awful.tag({ "7", "8", "9", "0" }, screen[1], layouts[1])
awful.tag({ "1" }, screen[2], layouts[2])
awful.tag({ "7", "8", "9", "0" }, screen[3], layouts[1])

local textclock = wibox.widget.textclock("%a %b %d, %H:%M:%S", 1)

local s_left = screen[1]

s_left.taglist = awful.widget.taglist({
	screen = s_left,
	filter = awful.widget.taglist.filter.all,
})

-- Create the wibox
s_left.mywibox = awful.wibar({ position = "bottom", screen = s_right, height = 25, bg = beautiful.bg_normal .. "00" })

-- Add widgets to the wibox
s_left.mywibox:setup({
	layout = wibox.layout.align.horizontal,
	-- s_left.mytasklist, -- Middle widget
	{ -- left widgets
		layout = wibox.layout.fixed.horizontal,
		-- s_left.taglist,
		wibox.container.margin(s_left.taglist, 900, 0, 0),
	},
	{ -- Left widgets
		layout = wibox.layout.fixed.horizontal,
		-- mylauncher,
		wibox.container.margin(textclock, 780, 0, 0),
	},
})
s_left.mywibox:setup({
	layout = wibox.layout.stack,
	{
		layout = wibox.container.place,
		valign = "center",
		halign = "center",
		wibox.container.margin(s_left.taglist, 0, 0, 0),
	},
	{
		layout = wibox.container.place,
		valign = "center",
		halign = "right",
		wibox.container.margin(textclock, 0, 10, 0),
	},
})

local s_right = screen[3]

s_right.taglist = awful.widget.taglist({
	screen = s_right,
	filter = awful.widget.taglist.filter.all,
})

-- Create the wibox
s_right.mywibox = awful.wibar({ position = "bottom", screen = s_right, height = 25, bg = beautiful.bg_normal .. "00" })

-- Add widgets to the wibox
s_right.mywibox:setup({
	layout = wibox.layout.stack,
	{
		layout = wibox.layout.align.horizontal, -- Left widgets
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.container.margin(textclock, 10, 0, 0),
		},
	},
	{
		layout = wibox.container.place,
		valign = "center",
		halign = "center",
		s_right.taglist, -- Middle widget
	},
})
