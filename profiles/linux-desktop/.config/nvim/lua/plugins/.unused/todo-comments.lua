return {
  "folke/todo-comments.nvim",
  enabled = false,
  config = function()
    local todo = require("todo-comments")
    local utils = require("utils")

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

    utils.set_keynomap("n", "<leader>I", "<cmd>LspInstall<cr>", "Install LSP")
  end
}
