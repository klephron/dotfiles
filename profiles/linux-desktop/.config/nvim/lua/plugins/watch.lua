local config = require("config")

return {
  "klephron/watch.nvim",
  dir = config.plugin.watch_dir,
  config = function()
    local watch = require("watch")
    watch.setup({})
  end,
}
