local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
}

awful.tag({ "7", "8", "9", "0" }, screen[1], layouts[2])
awful.tag({ "7", "8", "9", "0" }, screen[2], layouts[1])

local textclock = wibox.widget.textclock("%a %b %d, %H:%M:%S", 1)

local screen_left = screen[1]

screen_left.taglist = awful.widget.taglist({
	screen = screen_left,
	filter = awful.widget.taglist.filter.all,
})

-- Create the wibox
screen_left.mywibox = awful.wibar({
	position = "bottom",
	screen = screen_left,
	height = 25,
	bg = beautiful.bg_normal .. "00", -- totally transparent
})

-- Add widgets to the wibox
screen_left.mywibox:setup({
	layout = wibox.layout.align.horizontal,
	screen_left.mytasklist, -- Middle widget
	{ -- Right widgets
		layout = wibox.layout.fixed.horizontal,
		screen_left.taglist,
	},
	{ -- Left widgets
		layout = wibox.layout.fixed.horizontal,
		-- mylauncher,
		wibox.container.margin(textclock, 10, 0, 7),
	},
})

local screen_right = screen[2]

screen_right.taglist = awful.widget.taglist({
	screen = screen_right,
	filter = awful.widget.taglist.filter.all,
})

-- Create the wibox
screen_right.mywibox = awful.wibar({
	position = "bottom",
	screen = screen_right,
	height = 25,
	bg = beautiful.bg_normal .. "00", -- totally transparent
})

-- Add widgets to the wibox
screen_right.mywibox:setup({
	layout = wibox.layout.align.horizontal,
	{ -- Left widgets
		layout = wibox.layout.fixed.horizontal,
		-- mylauncher,
		wibox.container.margin(textclock, 10, 0, 7),
	},
	screen_right.mytasklist, -- Middle widget
	{ -- Right widgets
		layout = wibox.layout.fixed.horizontal,
		screen_right.taglist,
	},
})
