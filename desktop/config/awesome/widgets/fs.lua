local helpers = require("lain.helpers")
local wibox = require("wibox")
local shell = require("awful.util").shell
local lain = require("lain")

local markup = lain.util.markup

local function factory(args)
  args = args or {}

  local fs = { widget = args.widget or wibox.widget.textbox() }
  local timeout = args.timeout or 60
  local theme = args.theme

  function fs.update()
    helpers.async({ shell, "-c", "df -h / | tail -1 | awk '{print $5}'" }, function(f)
      local percent = tonumber(string.sub(f:gsub("%s+", ""), 1, -2))
      fs.widget:set_markup(markup.font(theme.font, " " .. percent .. "% " ))
    end)
  end

  helpers.newtimer("fs", timeout, fs.update)

  return fs
end

return factory
