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
        ok = { "DiagnosticOk", }
      }
    })
  end
}

return M
