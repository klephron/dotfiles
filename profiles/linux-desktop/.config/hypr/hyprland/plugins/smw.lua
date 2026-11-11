local api = require("plugins.split-monitor-workspaces")

local installed = (api.setup ~= nil)

if not installed then
  hl.notification.create({ text = "[split-monitor-workspaces]: not installed", timeout = 2000 })
end

local function config()
  if not installed then
    return
  end

  api.setup({
    workspace_count = 12,
    keep_focused = true,
    enable_notifications = false,
    enable_persistent_workspaces = true,
    link_monitors = false,
  })
end

return {
  api = api,
  installed = installed,
  config = config,
}
