local M = {
  config = function()
    local colors = require("hyprland.colors")

    hl.config({
      plugin = {
        hy3 = {
          tab_first_window = true,
          group_inset = 0,
          tabs = {
            height = 20,
            radius = 0,
            border_width = 0,
            padding = 0,
            text_height = 9,
            blur = false,
            render_text = true,
            colors = {
              active                    = colors.background_active,
              active_border             = colors.border_active,
              active_text               = colors.foreground_active,

              active_alt_monitor        = colors.background_focused,
              active_alt_monitor_border = colors.border_focused,
              active_alt_monitor_text   = colors.foreground_focused,

              focused                   = colors.background_focused,
              focused_border            = colors.border_focus,
              focused_text              = colors.foreground_focused,

              inactive                  = colors.background,
              inactive_border           = colors.border,
              inactive_text             = colors.foreground,

              urgent                    = colors.background_urgent,
              urgent_border             = colors.border_urgent,
              urgent_text               = colors.foreground_urgent,
            }
          }
        }
      }
    })
  end,
}

return M
