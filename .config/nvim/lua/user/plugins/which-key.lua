local M = {
  "folke/which-key.nvim",
  opts = {
    show_help = false,
    key_labels = {},
    triggers = { "leader", '"', '<c-r>' },
    triggers_nowait = {
      -- marks
      "`",
      "'",
      "g`",
      "g'",
      -- registers
      -- '"',
      -- "<c-r>",
      -- spelling
      "z=",
    }
  }
}

return M
