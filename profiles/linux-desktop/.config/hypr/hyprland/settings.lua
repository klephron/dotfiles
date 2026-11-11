local c = require("hyprland.config")

local p = {
  hy3 = require("hyprland.plugins.hy3"),
  smw = require("hyprland.plugins.split-monitor-workspaces"),
}

hl.config({
  debug = {
    disable_logs = false,
    suppress_errors = false,
    vfr = true,
  }
})

hl.config({
  ecosystem = {
    no_update_news = true
  }
})

hl.config({
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  }
})

hl.config({
  xwayland = {
    force_zero_scaling = true,
  }
})

hl.config({
  general = {
    gaps_in = 0,
    gaps_out = 0,
    layout = "dwindle",
    col = {
      active_border = c.colors.border_active,
    }
  }
})

hl.config({
  animations = {
    enabled = false
  }
})

hl.config({
  decoration = {
    blur = {
      enabled = false
    },
    shadow = {
      enabled = false
    }
  }
})

hl.config({
  input = {
    kb_layout = c.keyboard.layout,
    kb_options = c.keyboard.options,
    follow_mouse = 1,
    accel_profile = "flat",
    sensitivity = 0.0,
    repeat_delay = 180,
    repeat_rate = 45,
  }
})

if p.smw.installed then
  p.smw.setup()
end

if p.hy3.installed then
  p.hy3.setup(c.colors)
end
