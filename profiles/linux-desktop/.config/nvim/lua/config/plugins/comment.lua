local M = {
  'numToStr/Comment.nvim',
  dependencies = config.is_vscode and {} or {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  config = function()
    local comment = require("Comment")
    local funcs = require("utils.funcs")

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

    funcs.set_keynomap('x', '<C-/>', "<Plug>(comment_toggle_linewise_visual)'[gv")
    funcs.set_keynomap('x', '<C-S-/>', "<Plug>(comment_toggle_blockwise_visual)'[gv")

    funcs.set_keynomap('n', '<C-/>', function()
      local toggle_current_line = '<Plug>(comment_toggle_linewise_current)j'
      local toggle_count_lines = '<Plug>(comment_toggle_linewise_count)' .. vim.v.count .. 'j'
      return vim.v.count == 0 and toggle_current_line
          or toggle_count_lines
    end, { expr = true })
    funcs.set_keynomap('n', '<C-S-/>', function()
      local toggle_current_line = '<Plug>(comment_toggle_blockwise_current)j'
      local toggle_count_lines = '<Plug>(comment_toggle_blockwise_count)' .. vim.v.count .. 'j'
      return vim.v.count == 0 and toggle_current_line
          or toggle_count_lines
    end, { expr = true })
  end,
  keys = {
    { "gcc",     mode = { "n" } },
    { "gbc",     mode = { "n" } },
    { "gc",      mode = { "n", "x", "o" } },
    { "gb",      mode = { "n", "x", "o" }, },
    { "<C-/>",   mode = { "n", "x" } },
    { "<C-S-/>", mode = { "n", "x" } },
  },
}

return M
