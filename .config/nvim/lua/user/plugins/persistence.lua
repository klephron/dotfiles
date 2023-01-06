local M = {
  "folke/persistence.nvim",
  enabled = false,
  config = {
    dir = vim.fn.expand(vim.fn.stdpath("cache") .. "/persistence/"),
    options = { "buffers", "curdir", "folds", "help", "tabpages", "winsize", "winpos" },
  }
}

return M
