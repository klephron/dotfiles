local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme = {}

local function img_scaled(img_path, width, height)
  return gears.surface.load_from_shape(width, height,
    function(cr, w, h)
      local img = gears.surface(gears.surface.load(img_path))
      local img_width, img_height = gears.surface.get_size(img)

      local scale_x = w / img_width
      local scale_y = h / img_height

      cr:scale(scale_x, scale_y)
      cr:set_source_surface(img, 0, 0)
      cr:paint()
    end)
end

theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow-dark"
-- theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.wallpaper = "~/Documents/images/wallpaper/space_8k.jpg"
-- theme.font                                      = "Terminus 9"
theme.font = "Noto Sans 9"
theme.fg_normal = "#DDDDFF"
theme.fg_focus = "#388bff"
theme.fg_urgent = "#CC9393"
theme.bg_normal = "#1A1A1A"
theme.bg_focus = "#313131"
theme.bg_urgent = "#1A1A1A"
theme.border_width = dpi(1)
theme.border_normal = "#3F3F3F"
theme.border_focus = "#7F7F7F"
theme.border_marked = "#CC9393"
theme.tasklist_bg_focus = "#1A1A1A"
theme.titlebar_bg_focus = theme.bg_focus
theme.titlebar_bg_normal = theme.bg_normal
theme.titlebar_fg_focus = theme.fg_focus
theme.menu_height = dpi(16)
theme.menu_width = dpi(140)
theme.menu_submenu_icon = theme.dir .. "/icons/submenu.png"
theme.taglist_squares_sel = img_scaled(theme.dir .. "/icons/square_sel_14x14_right.png", dpi(14),
  dpi(14))
theme.taglist_squares_unsel = img_scaled(theme.dir .. "/icons/square_unsel_14x14_right.png", dpi(14),
  dpi(14))
theme.taglist_squares_resize = false
theme.layout_tile = theme.dir .. "/icons/tile.png"
theme.layout_tileleft = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv = theme.dir .. "/icons/fairv.png"
theme.layout_fairh = theme.dir .. "/icons/fairh.png"
theme.layout_spiral = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle = theme.dir .. "/icons/dwindle.png"
theme.layout_max = theme.dir .. "/icons/max.png"
theme.layout_fullscreen = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier = theme.dir .. "/icons/magnifier.png"
theme.layout_floating = theme.dir .. "/icons/floating.png"
theme.widget_ac = theme.dir .. "/icons/ac.png"
theme.widget_battery = theme.dir .. "/icons/battery.png"
theme.widget_battery_low = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem = theme.dir .. "/icons/mem.png"
theme.widget_cpu = theme.dir .. "/icons/cpu.png"
theme.widget_temp = theme.dir .. "/icons/temp.png"
theme.widget_net = theme.dir .. "/icons/net.png"
theme.widget_hdd = theme.dir .. "/icons/hdd.png"
theme.widget_music = theme.dir .. "/icons/note.png"
theme.widget_music_on = theme.dir .. "/icons/note_on.png"
theme.widget_vol = theme.dir .. "/icons/vol.png"
theme.widget_vol_low = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail = theme.dir .. "/icons/mail.png"
theme.widget_mail_on = theme.dir .. "/icons/mail_on.png"
theme.tasklist_plain_task_name = false
theme.tasklist_disable_icon = false
theme.useless_gap = dpi(0)
theme.titlebar_close_button_focus = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"

local markup = lain.util.markup
local separators = lain.util.separators

local keyboardlayout = awful.widget.keyboardlayout:new()

-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
  "date +'%a %d %b %T'", 1,
  function(widget, stdout)
    widget:set_markup(" " .. markup.font(theme.font, stdout))
  end
)

-- Calendar
theme.cal = lain.widget.cal({
  attach_to = { clock },
  notification_preset = {
    font = "Droid Sans Mono 10",
    fg   = theme.fg_normal,
    bg   = theme.bg_normal
  }
})

-- Mail IMAP check
local mailicon = wibox.widget.imagebox(theme.widget_mail)
--[[ commented because it needs to be set before use
mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_markup(markup.font(theme.font, " " .. mailcount .. " "))
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]

-- MPD
local musicplr = awful.util.terminal .. " -title Music -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(my_table.join(
  awful.button({ "Mod4" }, 1, function() awful.spawn(musicplr) end),
  awful.button({}, 1, function()
    os.execute("mpc prev")
    theme.mpd.update()
  end),
  awful.button({}, 2, function()
    os.execute("mpc toggle")
    theme.mpd.update()
  end),
  awful.button({}, 3, function()
    os.execute("mpc next")
    theme.mpd.update()
  end)))
theme.mpd = lain.widget.mpd({
  settings = function()
    local title = ""
    local artist = ""
    if mpd_now.state == "play" then
      artist = " " .. mpd_now.artist .. " "
      title = mpd_now.title .. " "
      mpdicon:set_image(theme.widget_music_on)
    elseif mpd_now.state == "pause" then
      artist = " mpd "
      title = "paused "
    else
      mpdicon:set_image(theme.widget_music)
    end

    widget:set_markup(markup.font(theme.font, markup("#EA6F81", artist) .. title))
  end
})

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
  timeout = 5,
  settings = function()
    widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
  end
})

-- CPU Sysload
local sysloadicon = wibox.widget.imagebox(theme.widget_cpu)
local sysload = lain.widget.sysload({
  timeout = 2,
  settings = function()
    widget:set_markup(markup.font(theme.font, " " .. load_1 .. "  " .. load_5 .. "  " .. load_15 .. " "))
  end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
  settings = function()
    widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
  end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
  timeout = 5,
  settings = function()
    widget:set_markup(markup.font(theme.font, " " .. math.floor(coretemp_now) .. "°C "))
  end,
  tempfile = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon4/temp1_input"
})

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
theme.fs = lain.widget.fs({
  notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10" },
  settings = function()
    widget:set_markup(markup.font(theme.font, " " .. fs_now["/"].percentage .. "% "))
  end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
  timeout = 5,
  settings = function()
    if bat_now.status and bat_now.status ~= "N/A" then
      if bat_now.ac_status == 1 then
        baticon:set_image(theme.widget_ac)
      elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
        baticon:set_image(theme.widget_battery_empty)
      elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
        baticon:set_image(theme.widget_battery_low)
      else
        baticon:set_image(theme.widget_battery)
      end
      widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
    else
      widget:set_markup(markup.font(theme.font, " AC "))
      baticon:set_image(theme.widget_ac)
    end
  end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
  timeout = 2,
  settings = function()
    if volume_now.status == "off" then
      volicon:set_image(theme.widget_vol_mute)
    elseif tonumber(volume_now.level) == 0 then
      volicon:set_image(theme.widget_vol_no)
    elseif tonumber(volume_now.level) <= 50 then
      volicon:set_image(theme.widget_vol_low)
    else
      volicon:set_image(theme.widget_vol)
    end

    widget:set_markup(markup.font(theme.font, " " .. volume_now.level .. "% "))
  end
})
theme.volume.widget:buttons(awful.util.table.join(
  awful.button({}, 4, function()
    awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +1%")
    theme.volume.update()
  end),
  awful.button({}, 5, function()
    awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -1%")
    theme.volume.update()
  end)
))


local neticon = wibox.widget.imagebox(theme.widget_net)

local net = lain.widget.net({
  units = 1,
  timeout = 2,
  settings = function()
    local get_net_string = function(units)
      local unit;
      local value;
      local format

      unit = "B "
      value = tonumber(units)

      if value >= 1000 then
        unit = "kB"
        value = value / (2 ^ 10)
      end

      if value >= 1000 then
        unit = "MB"
        value = value / (2 ^ 10)
      end

      if value >= 1000 then
        unit = "GB"
        value = value / (2 ^ 10)
      end

      if value < 10 then
        format = "%1.2f %s"
      elseif value < 100 then
        format = "%2.1f %s"
      else
        format = " %3.0f %s"
      end

      return string.format(format, value, unit)
    end

    widget:set_markup(markup.font("Noto Sans Mono 9",
      markup("#7AC82E", " " .. get_net_string(net_now.received))
      .. " " ..
      markup("#46A8C3", " " .. get_net_string(net_now.sent) .. " ")))
  end
})

-- Separators
local spr = wibox.widget.textbox(' ')
local arrl_dl = separators.arrow_left(theme.bg_focus, "alpha")
local arrl_ld = separators.arrow_left("alpha", theme.bg_focus)

function theme.at_screen_connect(s)
  -- Quake application
  s.quake = lain.util.quake({ app = awful.util.terminal })

  -- If wallpaper is a function, call it with the screen
  local wallpaper = theme.wallpaper
  if type(wallpaper) == "function" then
    wallpaper = wallpaper(s)
  end
  gears.wallpaper.maximized(wallpaper, s, true)

  -- Tags
  awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(my_table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 2, function() awful.layout.set(awful.layout.layouts[1]) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist({
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    layout  = {
      spacing = 0,
      layout  = wibox.layout.fixed.horizontal
    },
    -- widget_template = {
    --   {
    --     {
    --       {
    --         id     = 'text_role',
    --         widget = wibox.widget.textbox,
    --       },
    --       layout = wibox.layout.fixed.horizontal,
    --     },
    --     left   = 6,
    --     right  = 6,
    --     widget = wibox.container.margin
    --   },
    --   id     = 'background_role',
    --   widget = wibox.container.background,
    -- },
    buttons = awful.util.taglist_buttons,
  })

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = awful.util.tasklist_buttons,
    widget_template = {
      {
        {
          {
            id     = 'text_margin_role',
            widget = wibox.widget {
              forced_width = dpi(4),
              shape        = gears.shape.circle,
              widget       = wibox.widget.separator,
            }
          },
          margins = dpi(4),
          widget  = wibox.container.margin,
        },
        {
          id     = 'text_role',
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      id     = 'background_role',
      widget = wibox.container.background,
    },
  })

  s.myscreenindex = wibox.widget({
    {
      layout = wibox.layout.align.horizontal,
      {
        widget = wibox.container.margin,
        margins = dpi(4)
      },
      {
        widget = wibox.widget.textbox,
        text = "s" .. s.index,
      },
      {
        widget = wibox.container.margin,
        margins = dpi(4)
      },
    },
    widget = wibox.container.background,
    shape = gears.shape.rect,
  })

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18), bg = theme.bg_normal, fg = theme.fg_normal })
  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.container.background(s.myscreenindex, theme.border_normal),
      s.mytaglist,
      s.mypromptbox,
      spr,
    },
    s.mytasklist, -- Middle widget
    {             -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      spr,
      keyboardlayout,
      arrl_ld,
      --arrl_ld,
      --wibox.container.background(mpdicon, theme.bg_focus),
      --wibox.container.background(theme.mpd.widget, theme.bg_focus),
      --arrl_dl,
      wibox.container.background(volicon, theme.bg_focus),
      wibox.container.background(theme.volume.widget, theme.bg_focus),
      --wibox.container.background(mailicon, theme.bg_focus),
      --wibox.container.background(theme.mail.widget, theme.bg_focus),
      arrl_dl,
      memicon,
      mem.widget,
      arrl_ld,
      wibox.container.background(sysloadicon, theme.bg_focus),
      wibox.container.background(sysload.widget, theme.bg_focus),
      arrl_dl,
      tempicon,
      temp.widget,
      arrl_ld,
      wibox.container.background(fsicon, theme.bg_focus),
      wibox.container.background(theme.fs.widget, theme.bg_focus),
      arrl_dl,
      baticon,
      bat.widget,
      arrl_ld,
      wibox.container.background(neticon, theme.bg_focus),
      wibox.container.background(net.widget, theme.bg_focus),
      arrl_dl,
      clock,
      spr,
      arrl_ld,
      wibox.container.background(s.mylayoutbox, theme.bg_focus),
    },
  }
end

return theme
