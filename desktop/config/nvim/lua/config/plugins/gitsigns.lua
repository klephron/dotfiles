local M = {
  'lewis6991/gitsigns.nvim',
  config = function()
    local gitsigns = require("gitsigns")
    local funcs = require("utils.funcs")

    gitsigns.setup {
      signcolumn = false,
      numhl = true,
      current_line_blame = false,
      current_line_blame_opts = {
        delay = 500,
      },
    }

    local wk_ok, wk = pcall(require, "which-key")
    if wk_ok then
      wk.add({
        { "<leader>g",       group = "git" },
        { "<localleader>g",  group = "git" },
      })
    end

    funcs.set_keynomap("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", "gitsigns: blame line")
    funcs.set_keynomap("n", "<localleader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", "gitsigns: toggle current line blame")

  end,
}

return M
