local beautiful = require("beautiful")

-- beautiful.taglist_font = "sans 15"
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), "xresources")
beautiful.init(theme_path)

return beautiful
