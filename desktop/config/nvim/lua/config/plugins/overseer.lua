local M = {
  'stevearc/overseer.nvim',
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  event = "VeryLazy",
  keys = {
    { "<leader>o", group = "overseer" },
    { "<leader>o", "<cmd>OverseerOpen<cr>",   "overseer: open" },
    { "<leader>O", "<cmd>OverseerToggle<cr>", "overseer: toggle" },
  },
  config = function()
    local overseer = require("overseer")
    overseer.setup({
      strategy = {
        "toggleterm",
        quit_on_exit = "success",
      },
      task_list = {
        bindings = {
          ["q"] = "<cmd>OverseerClose<cr>"
        }
      }
    })
  end
}

return M
