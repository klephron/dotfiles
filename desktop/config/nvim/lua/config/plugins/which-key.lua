local M = {
  "folke/which-key.nvim",
  opts = {
    show_help = false,
    disable = {
      buftypes = config.is_vscode and {"", "acwrite", "help", "nofile", "nowrite", "quickfix", "terminal", "prompt"} or {}
    }
  }
}

return M
