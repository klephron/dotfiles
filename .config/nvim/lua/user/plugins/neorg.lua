local M = {
  "nvim-neorg/neorg",
  dependencies = {
    'vhyrro/neorg-telescope',
  },
  ft = "norg",
  build = ":Neorg sync-parsers",
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

      ["core.export"] = {},
      ["core.export.markdown"] = {},

      ['core.norg.journal'] = {
        config = {
          workspace = 'root',
          strategy = 'flat',
        }
      },

      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            root = "~/Workspaces/neorg",
            notes = "~/Workspaces/neorg/notes",
            tasks = "~/Workspaces/neorg/tasks",
            journal = "~/Workspaces/neorg/journal",
          },
          index = "index.norg",
        }
      },
    }
  })
end

return M
