local config = require("config")
local profiles = require("profiles")

return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  opts = {
    show_help = false,
    delay = function(_)
      return 250
    end,
    disable = {
      buftypes = config.profile.any(profiles.all.vscode)
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

    utils.set_keynomap("n", "<leader>?", "<cmd>WhichKey<cr>", "[whichkey] Open menu")
  end,
}
