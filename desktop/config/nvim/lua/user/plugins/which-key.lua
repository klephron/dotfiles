local M = {
  "folke/which-key.nvim",
  opts = {
    show_help = false,
    key_labels = {},
    triggers = "auto",
    triggers_nowait = {
      -- marks
      -- "`",
      -- "'",
      "g`",
      "g'",
      -- registers
      -- '"',
      -- "<c-r>",
      -- spelling
      "z=",
    },
    motions = {
      count = false,
    },
  }
}

return M
