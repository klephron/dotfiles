local settings = require("hyprland.settings")

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
      active_border = settings.colors.border_active,
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
    kb_layout = settings.kb_layout,
    kb_options = settings.kb_options,
    follow_mouse = 1,
    accel_profile = "flat",
    sensitivity = 0.0,
    repeat_delay = 180,
    repeat_rate = 45,
  }
})
