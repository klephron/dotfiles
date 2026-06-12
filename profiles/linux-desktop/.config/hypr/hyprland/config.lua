local colors = require("hyprland.colors")

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
    layout = "hy3",
    col = {
      active_border = colors.border_active,
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
    kb_layout = table.concat({ "us", "ru" }, ","),
    kb_options = table.concat({ "grp:alt_shift_toggle", "altwin:menu_win" }, ","),
    follow_mouse = 1,
    accel_profile = "flat",
    sensitivity = 0.0,
    repeat_delay = 180,
    repeat_rate = 45,
  }
})
