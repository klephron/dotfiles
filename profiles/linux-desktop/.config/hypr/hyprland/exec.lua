local c = require("hyprland.config")

hl.on("config.reloaded", function()
  if c.wallpaper.video.enabled then
    hl.exec_cmd(
      "systemctl --user is-active --quiet mpvpaper.scope || " ..
      "uwsm-app -s b -t scope -u mpvpaper.scope -- " ..
      "mpvpaper -o 'no-audio loop-file=inf' ALL " ..
      "'" .. c.wallpaper.video.source:gsub("'", "'\\''") .. "'"
    )
  else
    hl.exec_cmd([[
      if systemctl --user is-active --quiet mpvpaper.scope; then
        systemctl --user stop mpvpaper.scope
      fi
    ]])
  end
end)

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprpm reload -n")

  hl.exec_cmd("uwsm-app -s s -- lxpolkit")
  hl.exec_cmd("uwsm-app -s s -- waybar")
  hl.exec_cmd("uwsm-app -s b -- wl-paste --type text --watch cliphist store")
  hl.exec_cmd("uwsm-app -s b -- wl-paste --type image --watch cliphist store")
  hl.exec_cmd("uwsm-app -s b -- hyprpaper")
  hl.exec_cmd("uwsm-app -s b -- nm-applet")

  hl.exec_cmd("uwsm-app -- firefox", { workspace = 1 })
  hl.exec_cmd("uwsm-app -- Telegram", { workspace = 2 })
  hl.exec_cmd("uwsm-app -- throne", { workspace = 3 })
  hl.exec_cmd("uwsm-app -- obsidian", { workspace = 4 })
end)
