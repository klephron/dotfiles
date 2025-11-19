local M = {
  'stevearc/overseer.nvim',
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  event = "VeryLazy",
  config = function()
    local overseer = require("overseer")
    overseer.setup({
      strategy = {
        "toggleterm",
        quit_on_exit = "success",
      },
      task_list = {
        bindings = {
          ["<C-u>"] = "OpenVsplit",
          ["<C-y>"] = "OpenSplit",
          ["q"] = "<cmd>OverseerClose<cr>"
        }
      }
    })
  end,
  keys = {
    { "<leader>o", "<cmd>OverseerOpen<cr>",   desc = "Open overseer" },
    { "<leader>O", "<cmd>OverseerToggle<cr>", desc = "Toggle overseer" },
  },
}

return M
