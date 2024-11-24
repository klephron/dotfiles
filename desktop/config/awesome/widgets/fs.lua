local gears             = require("gears")
local awful             = require("awful")
local wibox             = require("wibox")
local beautiful         = require("beautiful")

local disk_path         = "/"

local disk_widget       = wibox.widget {
  {
    id = "icon",
    widget = wibox.widget.textbox,
    text = " ",
    font = beautiful.icon_font or "sans 12",
  },
  {
    id = "usage",
    widget = wibox.widget.textbox,
    text = "Loading...",
    font = beautiful.font or "sans 12",
  },
  layout = wibox.layout.fixed.horizontal,
  set_usage = function(self, usage)
    self:get_children_by_id("usage")[1].text = usage
  end,
}

-- Update the widget every 10 seconds
local update_disk_usage = function(widget)
  awful.spawn.easy_async_with_shell("df -h " .. disk_path .. " | awk 'NR==2 {print $5}'", function(stdout)
    local usage = stdout:match("(%d+)%%") or "N/A"
    widget:set_usage(usage .. "%")
  end)
end

-- Set up periodic updates
update_disk_usage(disk_widget)
gears.timer {
  timeout = 10,
  call_now = true,
  autostart = true,
  callback = function()
    update_disk_usage(disk_widget)
  end,
}

-- Return the widget
return disk_widget
