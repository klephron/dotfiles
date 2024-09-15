local M = {
  'stevearc/overseer.nvim',
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  opts = {
    strategy = {
      "toggleterm",
      quit_on_exit = "success",
    },
  },
  -- keys = {
  --   { "<leader>o", "overseer" },
  --   { "<leader>o", "<cmd>Overseer<cr>", desc = "whichkey: Open" },
  -- }
}

return M
