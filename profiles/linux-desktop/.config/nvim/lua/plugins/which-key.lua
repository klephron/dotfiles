return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    show_help = false,
    delay = function(ctx)
      return 200
    end,
    disable = {
      buftypes = _G.config.profiles_any("vscode")
        and { "", "acwrite", "help", "nofile", "nowrite", "quickfix", "terminal", "prompt", }
        or {}
    },
    icons = {
      mappings = false,
    },
    sort = { "mod", "alphanum", "order" },
  },
  config = function(_, opts)
    local funcs = require("utils.funcs")

    require("which-key").setup(opts)

    funcs.set_keynomap("n", "<leader>?", "<cmd>WhichKey<cr>", "Open which-key")
  end,
}
