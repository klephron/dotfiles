local M = {
  'numToStr/Comment.nvim',
  dependencies = config.is_vscode and {} or {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  keys = {
    { "gcc", mode = { "n" } },
    { "gbc", mode = { "n" } },
    { "gc",  mode = { "n", "x", "o" } },
    { "gb",  mode = { "n", "x", "o" }, },
  },
  config = function()
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
}

return M
