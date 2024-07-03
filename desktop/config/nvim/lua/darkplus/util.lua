local M = {}

local ts = require("darkplus.treesitter")

function M.highlight(group, hl)
  group = ts.get(group)
  vim.api.nvim_set_hl(0, group, hl)
end

function M.load(theme)
  for group, hl in pairs(theme) do
    M.highlight(group, hl)
  end
end

return M
