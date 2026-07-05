local colors = require("hyprland.colors")
local smw = require("hyprland.plugins").smw
local hy3 = require("hyprland.plugins").hy3

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
if hy3.installed() then
  hl.bind("SUPER + H", hy3.api.move_focus("l", { visible = true }))
  hl.bind("SUPER + J", hy3.api.move_focus("d", { visible = true }))
  hl.bind("SUPER + K", hy3.api.move_focus("u", { visible = true }))
  hl.bind("SUPER + L", hy3.api.move_focus("r", { visible = true }))

  hl.bind("SUPER + CTRL + H", hy3.api.move_window("l", { visible = true }))
  hl.bind("SUPER + CTRL + L", hy3.api.move_window("r", { visible = true }))
  hl.bind("SUPER + CTRL + K", hy3.api.move_window("u", { visible = true }))
  hl.bind("SUPER + CTRL + J", hy3.api.move_window("d", { visible = true }))
else
  hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
  hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))
  hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
  hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))

  hl.bind("SUPER + CTRL + H", hl.dsp.window.move({ direction = "l" }))
  hl.bind("SUPER + CTRL + L", hl.dsp.window.move({ direction = "r" }))
  hl.bind("SUPER + CTRL + K", hl.dsp.window.move({ direction = "u" }))
  hl.bind("SUPER + CTRL + J", hl.dsp.window.move({ direction = "d" }))
end

-- Groups
-- WARN: crashes when executing hy3:makegroup on root node with toggle, use hy3:changegroup shortcuts instead
-- related: https://github.com/outfoxxed/hy3/issues/213
if hy3.installed() then
  hl.bind("SUPER + U", hy3.api.make_group("h"))
  hl.bind("SUPER + Y", hy3.api.make_group("v"))
  hl.bind("SUPER + I", hy3.api.make_group("tab"))

  hl.bind("SUPER + SHIFT + U", hy3.api.change_group("h"))
  hl.bind("SUPER + SHIFT + Y", hy3.api.change_group("v"))
  hl.bind("SUPER + SHIFT + I", hy3.api.change_group("toggletab"))
end

if hy3.installed() then
  hl.bind("SUPER + SHIFT + H", hy3.api.focus_tab({ direction = "l", wrap = true }), { repeating = true })
  hl.bind("SUPER + SHIFT + L", hy3.api.focus_tab({ direction = "r", wrap = true }), { repeating = true })
  hl.bind("SUPER + A", hy3.api.focus_tab({ direction = "l", wrap = true }), { repeating = true })
  hl.bind("SUPER + D", hy3.api.focus_tab({ direction = "r", wrap = true }), { repeating = true })
end

if hy3.installed() then
  hl.bind("SUPER + SHIFT + 1", hy3.api.focus_tab({ index = 1 }))
  hl.bind("SUPER + SHIFT + 2", hy3.api.focus_tab({ index = 2 }))
  hl.bind("SUPER + SHIFT + 3", hy3.api.focus_tab({ index = 3 }))
  hl.bind("SUPER + SHIFT + 4", hy3.api.focus_tab({ index = 4 }))
  hl.bind("SUPER + SHIFT + 5", hy3.api.focus_tab({ index = 5 }))
  hl.bind("SUPER + SHIFT + 6", hy3.api.focus_tab({ index = 6 }))
  hl.bind("SUPER + SHIFT + 7", hy3.api.focus_tab({ index = 7 }))
  hl.bind("SUPER + SHIFT + 8", hy3.api.focus_tab({ index = 8 }))
  hl.bind("SUPER + SHIFT + 9", hy3.api.focus_tab({ index = 9 }))
  hl.bind("SUPER + SHIFT + 0", hy3.api.focus_tab({ index = 10 }))
  hl.bind("SUPER + SHIFT + minus", hy3.api.focus_tab({ index = 11 }))
  hl.bind("SUPER + SHIFT + equal", hy3.api.focus_tab({ index = 12 }))
end

if hy3.installed() then
  hl.bind("SUPER + SHIFT + CTRL + H", hy3.api.move_window("l", { once = true }), { repeating = true })
  hl.bind("SUPER + SHIFT + CTRL + L", hy3.api.move_window("r", { once = true }), { repeating = true })
  hl.bind("SUPER + CTRL + A", hy3.api.move_window("l", { once = true }), { repeating = true })
  hl.bind("SUPER + CTRL + D", hy3.api.move_window("r", { once = true }), { repeating = true })
end

-- Single
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- NOTE: it maximizes all clients in current workspace https://github.com/hyprwm/Hyprland/discussions/9935
hl.bind("SUPER + Z", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + Q", hl.dsp.window.close({}))
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill({}))

hl.bind("SUPER + semicolon", hl.dsp.submap("window_resize"))
hl.define_submap("window_resize", function()
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

  hl.bind("N", hl.dsp.submap("window_move"))
  hl.bind("SUPER + N", hl.dsp.submap("window_move"))
end)

hl.bind("SUPER + N", hl.dsp.submap("window_move"))
hl.define_submap("window_move", function()
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

  hl.bind("semicolon", hl.dsp.submap("window_resize"))
  hl.bind("SUPER + semicolon", hl.dsp.submap("window_resize"))
end)

hl.bind("SUPER + F4", function()
  hl.notification.create({ text = "[ignore]: entered", timeout = 1000 })
  hl.dispatch(hl.dsp.submap("bind_ignore"))
end)
hl.define_submap("bind_ignore", function()
  hl.bind("SUPER + F4", function()
    hl.notification.create({ text = "[ignore]: exited", timeout = 1000 })
    hl.dispatch(hl.dsp.submap("reset"))
  end)
end)

hl.bind("SUPER + F11", function()
  hl.notification.create({
    text = "[keyboard]: locked",
    timeout = 1000,
  })

  hl.dispatch(hl.dsp.submap("keyboard_lock"))
end)

hl.define_submap("keyboard_lock", function()
  hl.bind("SUPER + F11", function()
    hl.notification.create({
      text = "[keyboard]: unlocked",
      timeout = 1000,
    })

    hl.dispatch(hl.dsp.submap("reset"))
  end)

  hl.bind("catchall", function() end)
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
