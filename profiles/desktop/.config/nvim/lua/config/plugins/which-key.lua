local M = {
  "folke/which-key.nvim",
  opts = {
    show_help = false,
    delay = function(ctx)
      return 200
    end,
    disable = {
      buftypes = config.is_vscode and { "", "acwrite", "help", "nofile", "nowrite", "quickfix", "terminal", "prompt" } or
          {}
    },
    icons = {
      mappings = false,
    },
    sort = { "mod", "alphanum", "order" },
  },
  keys = {
    { "<leader>?", "<cmd>WhichKey<cr>", desc = "Open whichkey" },
  }
}

return M
