local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local layouts = {
	awful.layout.suit.tile,
}

-- local battery_widget = require("awesome-wm-widgets.battery-widget.battery")({ display_notification = true })
local battery_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")({
	size = 20,
	show_notification_mode = "on_click",
})

awful.tag({ "1", "2", "3", "4" }, screen[1], layouts[1])

local textclock = wibox.widget.textclock("%a %b %d, %H:%M:%S", 1)

local s_left = screen[1]

s_left.taglist = awful.widget.taglist({
	screen = s_left,
	filter = awful.widget.taglist.filter.all,
})

s_left.mywibox = awful.wibar({ position = "top", screen = s_left, height = 30, bg = beautiful.bg_normal .. "00" })

s_left.mywibox:setup({
	layout = wibox.layout.stack,
	{
		layout = wibox.container.place,
		valign = "center",
		halign = "left",
		{
			{
				battery_widget,
				left = 15,
				right = 15,
				top = 1,
				bottom = 1,
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
		halign = "center",
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
})
