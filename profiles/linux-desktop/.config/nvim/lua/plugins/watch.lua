local config = require("config")

return {
  "https://git.klephron.xyz/klephron/nvim-watch",
  dir = config.plugins.watch_dir,
  config = function()
    local watch = require("watch")
    watch.setup({})
  end,
}
