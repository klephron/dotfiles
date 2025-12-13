local M = {
  "kwkarlwang/bufjump.nvim",
  config = function()
    local bufjump = require("bufjump")

    bufjump.setup({
      forward_key = "<C-n>",
      backward_key = "<C-p>",
      on_success = function()
        vim.cmd([[execute "normal! g`\"zz"]])
      end,
    })
  end,
}

return M
