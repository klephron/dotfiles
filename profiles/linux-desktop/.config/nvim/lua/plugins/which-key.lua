local config = require("config")

return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  opts = {
    show_help = false,
    delay = function(_)
      return 200
    end,
    disable = {
      buftypes = config.profile.contains("vscode")
        and { "", "acwrite", "help", "nofile", "nowrite", "quickfix", "terminal", "prompt", }
        or {}
    },
    icons = {
      mappings = false,
    },
    sort = { "mod", "alphanum", "order" },
  },

  config = function(_, opts)
    local utils = require("utils")

    require("which-key").setup(opts)

    utils.set_keynomap("n", "<leader>?", "<cmd>WhichKey<cr>", "Open which-key")
  end,
}
