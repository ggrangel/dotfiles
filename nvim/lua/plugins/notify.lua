local notify = require "notify"

notify.setup {
  background_colour = "Normal",
  fps = 30,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = "",
  },
  level = "info",
  minimum_width = 1,
  render = "default",
  stages = "fade_in_slide_out",
  timeout = 0, -- minimum value
}

vim.notify = notify
