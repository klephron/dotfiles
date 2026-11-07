local config = require("config")

return {
  "https://git.klephron.xyz/klephron/nvim-watch",
  dir = config.plugin.watch_dir,
  config = function()
    local watch = require("watch")
    watch.setup({})
  end,
}
