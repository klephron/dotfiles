local c = require("hyprland.config")

local api = hl.plugin.hy3

local function setup()
  hl.config({
    general = {
      layout = "hy3",
    },

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
            active                    = c.colors.background_active,
            active_border             = c.colors.border_active,
            active_text               = c.colors.foreground_active,

            active_alt_monitor        = c.colors.background_focused,
            active_alt_monitor_border = c.colors.border_focused,
            active_alt_monitor_text   = c.colors.foreground_focused,

            focused                   = c.colors.background_focused,
            focused_border            = c.colors.border_focus,
            focused_text              = c.colors.foreground_focused,

            inactive                  = c.colors.background,
            inactive_border           = c.colors.border,
            inactive_text             = c.colors.foreground,

            urgent                    = c.colors.background_urgent,
            urgent_border             = c.colors.border_urgent,
            urgent_text               = c.colors.foreground_urgent,
          }
        }
      }
    }
  })
end

local installed = (api ~= nil)

if not installed then
  hl.notification.create({ text = "[hy3]: not installed", timeout = 2000 })
end

return {
  api = api,
  installed = installed,
  setup = setup,
}
