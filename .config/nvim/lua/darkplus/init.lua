local M = {}
local theme = require('darkplus.theme')
local util = require('darkplus.util')

M.setup = function()
  vim.cmd('hi clear')

  vim.o.background = 'dark'
  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end

  vim.o.termguicolors = true
  vim.g.colors_name = 'darkplus'
  util.load(theme.highlights)
end

return M
