local M = {}

M.api = require("plugins.split-monitor-workspaces")

M.installed = function()
  return M.api.setup ~= nil
end

M.config = function()
  M.api.setup({
    workspace_count = 12,
    keep_focused = true,
    enable_notifications = false,
    enable_persistent_workspaces = true,
    link_monitors = false,
  })
end

return M
