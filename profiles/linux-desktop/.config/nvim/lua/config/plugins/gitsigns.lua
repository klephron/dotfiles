local M = {
  'lewis6991/gitsigns.nvim',
  event = "BufRead",
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
  end,

  keys = {
    { "<leader>gb",      "<cmd>Gitsigns blame_line<cr>",                mode = "n", desc = "Blame line" },
    { "<leader>gr",      "<cmd>Gitsigns refresh<cr>",                   mode = "n", desc = "Refresh" },
    { "<localleader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", mode = "n", desc = "Toggle current line blame" },
  }
}

return M
