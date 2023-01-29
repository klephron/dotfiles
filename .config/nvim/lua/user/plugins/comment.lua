local M = {
  'numToStr/Comment.nvim',
  keys = {
    { "gc", mode = "n" },
    { "gc", mode = "v" },
    { "gb", mode = "n" },
    { "gb", mode = "v" },
  },
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
