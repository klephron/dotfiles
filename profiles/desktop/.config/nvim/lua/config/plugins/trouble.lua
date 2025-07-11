local M = {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  config = function()
    local funcs = require("utils.funcs")
    local trouble = require("trouble")

    trouble.setup({
      use_diagnostic_signs = true,
      action_keys = {
        close = "Q"
      }
    })

    funcs.augroup("local_trouble", {
      {
        event = "FileType",
        pattern = "Trouble",
        command = function()
          funcs.set_keynomap("n", "q", function()
            vim.cmd('wincmd p')
            vim.cmd('silent! TroubleClose')
          end, { buffer = 0 })
        end
      },
    })
  end,
  keys = {
    { "<leader>i", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Toggle diagnostics menu" },
  }
}

return M
