local M = {}
local theme = l_require('darkplus.theme')
local util = l_require('darkplus.util')

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
