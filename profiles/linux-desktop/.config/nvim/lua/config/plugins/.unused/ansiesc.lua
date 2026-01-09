local M = {
  'powerman/vim-plugin-AnsiEsc',
  event = 'BufRead',
  lazy = false,
  enabled = false,
  init = function()
    vim.g.no_cecutil_maps = 1
    vim.g.no_ansiesc_menu = 1
  end,
  config = function()
  end,
  keys = {
    { "<localleader>t", "<cmd>AnsiEsc<cr>", desc = "Escape Ansi codes" },
  },
  cmd = { "AnsiEsc" },
}

return M
