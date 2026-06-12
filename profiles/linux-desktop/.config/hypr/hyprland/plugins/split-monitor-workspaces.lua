local M = {
  config = function()
    local smw = require("plugins.split-monitor-workspaces.")

    smw.setup({
      count = 12,
      keep_focused = 0,
      enable_notifications = 0,
      enable_persistent_workspaces = 1,
    })
  end,
  binds = {

  }
}

return M
