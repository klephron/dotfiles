return {
  "klephron/watch.nvim",
  dir = vim.env.NVIM_CONFIG_WATCH_DIR or nil,
  config = function()
    local watch = require("watch")
    watch.setup({})
  end,
}
