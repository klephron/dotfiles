local M = {
  "klephron/watch.nvim",
  -- dir = vim.fn.expand("$HOME/works/watch.nvim/"),
  config = function()
    local watch = require("watch")
    watch.setup({})
  end,
}

return M
