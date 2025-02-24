local M = {
  'Makaze/AnsiEsc',
  event = 'BufRead',
  lazy = false,
  init = function()
    vim.g.no_cecutil_maps = 1
    vim.g.no_ansiesc_menu = 1
  end,
  config = function()
  end,
  keys = {
    { "<localleader>t", "<cmd>AnsiEsc<cr>", desc = "ansiesc: Escape Ansi codes" },
  },
  cmd = { "AnsiEsc" },
}

return M
