local colors = require("hyprland.colors")
local smw = require("hyprland.plugins").smw

-- SYSTEM
hl.bind("SUPER + CTRL + backspace", hl.dsp.exec_cmd("uwsm stop"))
-- NOTE: until resolved https://github.com/Alexays/Waybar/issues/2993
hl.bind("SUPER + CTRL + R", hl.dsp.exec_cmd("pkill waybar; uwsm-app -s s -- waybar"))

-- MONITORS
hl.bind("SUPER + comma", hl.dsp.focus({ monitor = "l" }))
hl.bind("SUPER + period", hl.dsp.focus({ monitor = "r" }))

-- WORKSPACES
if smw.installed() then
  hl.bind("SUPER + 1", smw.api.workspace("1"))
  hl.bind("SUPER + 2", smw.api.workspace("2"))
  hl.bind("SUPER + 3", smw.api.workspace("3"))
  hl.bind("SUPER + 4", smw.api.workspace("4"))
  hl.bind("SUPER + 5", smw.api.workspace("5"))
  hl.bind("SUPER + 6", smw.api.workspace("6"))
  hl.bind("SUPER + 7", smw.api.workspace("7"))
  hl.bind("SUPER + 8", smw.api.workspace("8"))
  hl.bind("SUPER + 9", smw.api.workspace("9"))
  hl.bind("SUPER + 0", smw.api.workspace("10"))
  hl.bind("SUPER + minus", smw.api.workspace("11"))
  hl.bind("SUPER + equal", smw.api.workspace("12"))
else
  hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
  hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
  hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
  hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
  hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
  hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
  hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
  hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
  hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
  hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))
  hl.bind("SUPER + minus", hl.dsp.focus({ workspace = 11 }))
  hl.bind("SUPER + equal", hl.dsp.focus({ workspace = 12 }))
end

if smw.installed() then
  hl.bind("SUPER + SHIFT + comma", smw.api.cycle_workspaces("-1"))
  hl.bind("SUPER + SHIFT + period", smw.api.cycle_workspaces("+1"))
  hl.bind("SUPER + S", smw.api.cycle_workspaces("-1"))
  hl.bind("SUPER + W", smw.api.cycle_workspaces("+1"))
end

hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "previous_per_monitor" }))

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

-- CLIENTS
-- Monitors
hl.bind("SUPER + CTRL + comma", hl.dsp.window.move({ monitor = "-1", follow = false }), { repeating = true })
hl.bind("SUPER + CTRL + period", hl.dsp.window.move({ monitor = "+1", follow = false }), { repeating = true })


if smw.installed() then
  hl.bind("SUPER + CTRL + backslash", smw.api.grab_rogue_windows())
end

-- Workspaces
if smw.installed() then
  hl.bind("SUPER + CTRL + 1", smw.api.move_to_workspace_silent("1"))
  hl.bind("SUPER + CTRL + 2", smw.api.move_to_workspace_silent("2"))
  hl.bind("SUPER + CTRL + 3", smw.api.move_to_workspace_silent("3"))
  hl.bind("SUPER + CTRL + 4", smw.api.move_to_workspace_silent("4"))
  hl.bind("SUPER + CTRL + 5", smw.api.move_to_workspace_silent("5"))
  hl.bind("SUPER + CTRL + 6", smw.api.move_to_workspace_silent("6"))
  hl.bind("SUPER + CTRL + 7", smw.api.move_to_workspace_silent("7"))
  hl.bind("SUPER + CTRL + 8", smw.api.move_to_workspace_silent("8"))
  hl.bind("SUPER + CTRL + 9", smw.api.move_to_workspace_silent("9"))
  hl.bind("SUPER + CTRL + 0", smw.api.move_to_workspace_silent("10"))
  hl.bind("SUPER + CTRL + minus", smw.api.move_to_workspace_silent("11"))
  hl.bind("SUPER + CTRL + equal", smw.api.move_to_workspace_silent("12"))
end

if smw.installed() then
  hl.bind("SUPER + SHIFT + CTRL + comma", smw.api.move_to_workspace("-1"), { repeating = true })
  hl.bind("SUPER + SHIFT + CTRL + period", smw.api.move_to_workspace("+1"), { repeating = true })

  hl.bind("SUPER + CTRL + S", smw.api.move_to_workspace("-1"), { repeating = true })
  hl.bind("SUPER + CTRL + W", smw.api.move_to_workspace("+1"), { repeating = true })
end

-- Windows
-- bind = SUPER, H, hy3:movefocus, l, visible
-- bind = SUPER, J, hy3:movefocus, d, visible
-- bind = SUPER, K, hy3:movefocus, u, visible
-- bind = SUPER, L, hy3:movefocus, r, visible
--
-- bind = SUPER_CTRL, H, hy3:movewindow, l, visible
-- bind = SUPER_CTRL, L, hy3:movewindow, r, visible
-- bind = SUPER_CTRL, K, hy3:movewindow, u, visible
-- bind = SUPER_CTRL, J, hy3:movewindow, d, visible
--
-- # Groups
-- # WARN: crashes when executing hy3:makegroup on root node with toggle, use hy3:changegroup shortcuts instead
-- # related: https://github.com/outfoxxed/hy3/issues/213
-- bind = SUPER, U, hy3:makegroup, h
-- bind = SUPER, Y, hy3:makegroup, v
-- bind = SUPER, I, hy3:makegroup, tab
--
-- bind = SUPER_SHIFT, U, hy3:changegroup, h
-- bind = SUPER_SHIFT, Y, hy3:changegroup, v
-- bind = SUPER_SHIFT, I, hy3:changegroup, toggletab
--
-- bind = SUPER_SHIFT, H, hy3:focustab, l, wrap
-- bind = SUPER_SHIFT, L, hy3:focustab, r, wrap
-- bind = SUPER, A, hy3:focustab, l, wrap
-- bind = SUPER, D, hy3:focustab, r, wrap
--
-- bind = SUPER_SHIFT, 1,     hy3:focustab, index, 1
-- bind = SUPER_SHIFT, 2,     hy3:focustab, index, 2
-- bind = SUPER_SHIFT, 3,     hy3:focustab, index, 3
-- bind = SUPER_SHIFT, 4,     hy3:focustab, index, 4
-- bind = SUPER_SHIFT, 5,     hy3:focustab, index, 5
-- bind = SUPER_SHIFT, 6,     hy3:focustab, index, 6
-- bind = SUPER_SHIFT, 7,     hy3:focustab, index, 7
-- bind = SUPER_SHIFT, 8,     hy3:focustab, index, 8
-- bind = SUPER_SHIFT, 9,     hy3:focustab, index, 9
-- bind = SUPER_SHIFT, 0,     hy3:focustab, index, 10
-- bind = SUPER_SHIFT, minus, hy3:focustab, index, 11
-- bind = SUPER_SHIFT, equal, hy3:focustab, index, 12
--
-- binde = SUPER_SHIFT_CTRL, H, hy3:movewindow, l, once
-- binde = SUPER_SHIFT_CTRL, L, hy3:movewindow, r, once
-- binde = SUPER_CTRL, A, hy3:movewindow, l, once
-- binde = SUPER_CTRL, D, hy3:movewindow, r, once

-- Single
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- NOTE: it maximizes all clients in current workspace https://github.com/hyprwm/Hyprland/discussions/9935
hl.bind("SUPER + Z", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + Q", hl.dsp.window.close({}))
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill({}))

hl.bind("SUPER + semicolon", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  hl.bind("L", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })
  hl.bind("H", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true })
  hl.bind("J", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true })

  hl.bind("SHIFT + L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  hl.bind("SHIFT + H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind("SHIFT + K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
  hl.bind("SHIFT + J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

  hl.bind("SUPER + semicolon", hl.dsp.submap("reset"))
  hl.bind("semicolon", hl.dsp.submap("reset"))
  hl.bind("return", hl.dsp.submap("reset"))
  hl.bind("escape", hl.dsp.submap("reset"))

  hl.bind("N", hl.dsp.submap("move"))
  hl.bind("SUPER + N", hl.dsp.submap("move"))
end)

hl.bind("SUPER + N", hl.dsp.submap("move"))
hl.define_submap("move", function()
  hl.bind("L", hl.dsp.window.move({ x = 100, y = 0, relative = true }), { repeating = true })
  hl.bind("H", hl.dsp.window.move({ x = -100, y = 0, relative = true }), { repeating = true })
  hl.bind("K", hl.dsp.window.move({ x = 0, y = -100, relative = true }), { repeating = true })
  hl.bind("J", hl.dsp.window.move({ x = 0, y = 100, relative = true }), { repeating = true })

  hl.bind("SHIFT + L", hl.dsp.window.move({ x = 10, y = 0, relative = true }), { repeating = true })
  hl.bind("SHIFT + H", hl.dsp.window.move({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind("SHIFT + K", hl.dsp.window.move({ x = 0, y = -10, relative = true }), { repeating = true })
  hl.bind("SHIFT + J", hl.dsp.window.move({ x = 0, y = 10, relative = true }), { repeating = true })

  hl.bind("SUPER + N", hl.dsp.submap("reset"))
  hl.bind("N", hl.dsp.submap("reset"))
  hl.bind("return", hl.dsp.submap("reset"))
  hl.bind("escape", hl.dsp.submap("reset"))

  hl.bind("semicolon", hl.dsp.submap("resize"))
  hl.bind("SUPER + semicolon", hl.dsp.submap("resize"))
end)

hl.bind("F11", function()
  hl.notification.create({ text = "[ignore]: entered", timeout = 1000 })
  hl.dispatch(hl.dsp.submap("ignore"))
end)
hl.define_submap("ignore", function()
  hl.bind("F11", function()
    hl.notification.create({ text = "[ignore]: exited", timeout = 1000 })
    hl.dispatch(hl.dsp.submap("reset"))
  end)
end)

-- APPS
hl.bind("SUPER + return", hl.dsp.exec_cmd("uwsm-app -- kitty"))
hl.bind("SUPER + SHIFT + return", hl.dsp.exec_cmd("uwsm-app -- alacritty"))

hl.bind("SUPER + B", hl.dsp.exec_cmd("uwsm-app -- firefox -P first"))
hl.bind("SUPER + CTRL + B", hl.dsp.exec_cmd("uwsm-app -- firefox -P second"))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("uwsm-app -- google-chrome"))

hl.bind("SUPER + E", hl.dsp.exec_cmd("uwsm-app -- pcmanfm"))

hl.bind("SUPER + O", hl.dsp.exec_cmd("uwsm-app -- rofi -show drun"))
hl.bind("SUPER + R", hl.dsp.exec_cmd("uwsm-app -- rofi -show run"))

hl.bind("SUPER + P", hl.dsp.exec_cmd("uwsm-app -- cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("uwsm-app -- cliphist wipe"))

hl.bind("SUPER + T", hl.dsp.exec_cmd("uwsm-app -- hyprlock"))

hl.bind("SUPER + SHIFT + X", hl.dsp.exec_cmd("uwsm-app -- $XDG_CONFIG_HOME/hypr/plugins/hyprland-binds-rofi/main.py"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("uwsm-app -- $XDG_CONFIG_HOME/hypr/scripts/power_menu"))

hl.bind("print", hl.dsp.exec_cmd("uwsm-app -- hyprshot -m region --clipboard-only --silent"))
hl.bind("SHIFT + print", hl.dsp.exec_cmd("uwsm-app -- hyprshot -m window --clipboard-only --silent"))
hl.bind("CTRL + print", hl.dsp.exec_cmd("uwsm-app -- hyprshot -m output -m active --clipboard-only --silent"))
hl.bind("CTRL + SHIFT + print", hl.dsp.exec_cmd("uwsm-app -- grimblast copysave screen -"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"))
