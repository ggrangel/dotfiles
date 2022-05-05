local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local layouts = {
	awful.layout.suit.tile,
}

awful.tag({ "1", "2", "3", "4" }, screen[1], layouts[1])

local textclock = wibox.widget.textclock("%a %b %d, %H:%M:%S", 1)

local s_left = screen[1]

s_left.taglist = awful.widget.taglist({
	screen = s_left,
	filter = awful.widget.taglist.filter.all,
})

-- Create the wibox
s_left.mywibox = awful.wibar({ position = "top", screen = s_right, height = 25, bg = beautiful.bg_normal .. "00" })

s_left.mywibox:setup({
	layout = wibox.layout.stack,
	{
		layout = wibox.container.place,
		valign = "center",
		halign = "right",
		{
			{
				s_left.taglist,
				left = 15,
				right = 15,
				widget = wibox.container.margin,
			},
			shape = gears.shape.hexagon,
			widget = wibox.container.background,
			bg = "#00000055",
		},
	},
	{
		layout = wibox.container.place,
		valign = "center",
		halign = "left",
		{
			{
				textclock,
				left = 15,
				right = 15,
				widget = wibox.container.margin,
			},
			shape = gears.shape.hexagon,
			widget = wibox.container.background,
			bg = "#00000055",
		},
	},
})
