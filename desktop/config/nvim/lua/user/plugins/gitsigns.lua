local M = {
  'lewis6991/gitsigns.nvim',
  config = function()
    local gitsigns = require("gitsigns")

    gitsigns.setup {
      signcolumn = false,
      numhl = true,
      current_line_blame = false,
      current_line_blame_opts = {
        delay = 500,
      },
    }
  end
}

return M
