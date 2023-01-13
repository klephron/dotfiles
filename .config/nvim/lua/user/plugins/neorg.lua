local M = {
  "nvim-neorg/neorg",
  ft = "norg",
  dependencies = {
    'vhyrro/neorg-telescope',
  },
  cmd = { "Neorg" },
}

function M.config()
  local neorg = require("neorg")
  neorg.setup({
    load = {
      ["core.defaults"] = {}, -- https://github.com/nvim-neorg/neorg/wiki#default-modules

      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        }
      },

      ["core.norg.concealer"] = {},

      ["core.integrations.telescope"] = {},

      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            default = "~/workspace/neorg",
            notes = "~/workspace/neorg/notes",
            tasks = "~/workspace/neorg/tasks",
          },
          index = "index.norg",
        }
      },
    }
  })
end

return M
