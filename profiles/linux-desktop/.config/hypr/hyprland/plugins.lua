local M = {
  smw = require("hyprland.plugins.split-monitor-workspaces"),
  hy3 = require("hyprland.plugins.hy3"),
}

if not M.smw.installed() then
  hl.notification.create({ text = "[split-monitor-workspaces]: not installed", timeout = 2000 })
else
  M.smw.config()
end

if not M.hy3.installed() then
  hl.notification.create({ text = "[hy3]: not installed", timeout = 2000 })
else
  M.hy3.config()
end

return M
