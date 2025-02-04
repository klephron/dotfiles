local M = {
  'stevearc/overseer.nvim',
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  event = "VeryLazy",
  opts = {
    strategy = {
      "toggleterm",
      quit_on_exit = "success",
    },
  },
}

return M
