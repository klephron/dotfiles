local M = {
  'numToStr/Comment.nvim',
  keys = { "gc", "gb" },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  }
}

function M.config()
  local comment = require("Comment")

  comment.setup({
    toggler = {
      line = 'gcc',
      block = 'gbc',
    },
    opleader = {
      line = 'gc',
      block = 'gb',
    },
    mappings = {
      basic = true,
      extra = true,
      extended = false,
    },
    ignore = function() return '^$' end,
  })
end

return M
