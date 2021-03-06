local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
}

awful.tag({ "1", "2", "3", "4" }, screen[1], layouts[1])
awful.tag({ "1", "2", "3", "4" }, screen[2], layouts[2])
awful.tag({ "1", "2", "3", "4" }, screen[3], layouts[1])

local textclock = wibox.widget.textclock("%a %b %d, %H:%M:%S", 1)

local s_left = screen[1]

s_left.taglist = awful.widget.taglist({
	screen = s_left,
	filter = awful.widget.taglist.filter.all,
})

-- Create the wibox
s_left.mywibox = awful.wibar({ position = "top", screen = s_left, height = 30, bg = beautiful.bg_normal .. "00" })

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

local s_mid = screen[2]

s_mid.taglist = awful.widget.taglist({
	screen = s_mid,
	filter = awful.widget.taglist.filter.all,
})

-- Create the wibox
s_mid.mywibox = awful.wibar({ position = "top", screen = s_mid, height = 30, bg = beautiful.bg_normal .. "00" })

s_mid.mywibox:setup({
	layout = wibox.layout.stack,
	{
		layout = wibox.container.place,
		valign = "center",
		halign = "center",
		{
			{
				s_mid.taglist,
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

local s_right = screen[3]

s_right.taglist = awful.widget.taglist({
	screen = s_right,
	filter = awful.widget.taglist.filter.all,
})

-- Create the wibox
s_right.mywibox = awful.wibar({ position = "top", screen = s_right, height = 30, bg = beautiful.bg_normal .. "00" })

-- Add widgets to the wibox
s_right.mywibox:setup({
	layout = wibox.layout.stack,
	{
		layout = wibox.container.place,
		valign = "center",
		halign = "right",
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
	{
		layout = wibox.container.place,
		valign = "center",
		halign = "left",
		{
			{
				s_right.taglist,
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
