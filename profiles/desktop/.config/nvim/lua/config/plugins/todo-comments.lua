local M = {
  "folke/todo-comments.nvim",
  config = function()
    local todo = require("todo-comments")
    todo.setup({
      signs = false,
      keywords = {
        FIX = {
          color = "error",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "ERROR" },
        },
        NOTE = { color = "ok", alt = { "INFO" } },
      },
      colors = {
        ok = { "DiagnosticUnnecessary", }
      },
      search = {
        command = "rg",
        args = {
          "--hidden",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
      }
      -- NOTE:
      -- disable highlighting
      -- highlight = {
      --   pattern = [[xkfiqpd]]
      -- }
    })
  end,
  keys = {
    { "<leader>I", "<cmd>TodoTelescope<cr>", desc = "List todos" },
  }
}

return M
