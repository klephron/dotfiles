local M = {
  'powerman/vim-plugin-AnsiEsc',
  event = 'BufRead',
  lazy = false,
  config = function()
  end,
  keys = {
    { "<localleader>t", "<cmd>AnsiEsc<cr>", desc = "ansiesc: Escape Ansi codes" },
  },
  cmd = { "AnsiEsc" },
}

return M
