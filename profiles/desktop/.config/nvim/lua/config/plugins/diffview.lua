local M = {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  config = function()
    local dv = require("diffview")
    dv.setup({
      enhanced_diff_hl = true,
      default_args = {
        DiffviewFileHistory = { '%' },
      },
      hooks = {
        diff_buf_read = function()
          vim.wo.wrap = false
          vim.wo.list = false
          vim.wo.colorcolumn = ''
        end,
      },
      keymaps = {
        view = { q = '<cmd>DiffviewClose<cr>' },
        file_panel = { q = '<cmd>DiffviewClose<cr>' },
        file_history_panel = { q = '<cmd>DiffviewClose<cr>' },
      },
    })
  end,
  keys = {
    { "<localleader>dh", "<cmd>DiffviewFileHistory<cr>", desc = "Open file history" },
    { "<localleader>do", "<cmd>DiffviewOpen<cr>",        desc = "Open diffview" },
  }
}

return M
