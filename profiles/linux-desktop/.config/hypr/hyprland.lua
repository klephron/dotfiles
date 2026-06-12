require("hyprland.config")
require("hyprland.hardware")
require("hyprland.binds")
require("hyprland.rules")

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

  -- hl.exec_cmd("uwsm-app -- /opt/v2rayn-bin/v2rayN", { workspace = 3 })
end)
