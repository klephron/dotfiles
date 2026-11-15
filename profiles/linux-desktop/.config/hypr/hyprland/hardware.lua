local c = require("hyprland.config")
local p = require("hyprland.common")
local u = require("hyprland.utils")

if c.monitor.layout.any(p.monitor.layouts.nwg) then
  require("monitors")
end

if c.monitor.layout.any(p.monitor.layouts.laptop) then
  hl.monitor({
    output   = "desc:Chimei Innolux Corporation 0x15E8", -- hdc-tecno eDP
    mode     = "1920x1080@60",
    position = "320x1440",
    scale    = 1,
  })
end

hl.device({
  name = "htix5288:00-093a:0255-touchpad", -- hdc-tecno touchpad
  sensitivity = 0.1,
  accel_profile = "adaptive",
  natural_scroll = true,
})

if c.monitor.layout.any(p.monitor.layouts.laptop, p.monitor.layouts.pc) then
  local function apply(spec)
    hl.monitor(u.merge({
      output = "desc:LG Electronics LG ULTRAFINE 404NTEPHQ268"
    }, spec))
  end
  if c.monitor.layout.any(p.monitor.layouts.laptop) then
    apply({
      mode = "3840x2160@60",
      position = "0x0",
      scale = 1.5,
    })
  end
  if c.monitor.layout.any(p.monitor.layouts.pc) then
    apply({
      mode = "3840x2160@60",
      position = "0x0",
      scale = 1.5,
    })
  end
end
