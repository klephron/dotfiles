local M = {
  "nvim-neorg/neorg",
  dependencies = {
    'vhyrro/neorg-telescope',
  },
  enabled = false, -- WARN: config deprecated
  ft = "norg",
  cmd = { "Neorg" },
  build = ":Neorg sync-parsers",
  config = function()
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
              root = "~/Documents/neorg",
              notes = "~/Documents/neorg/notes",
              tasks = "~/Documents/neorg/tasks",
              journal = "~/Documents/neorg/journal",
            },
            index = "index.norg",
          }
        },
      }
    })
  end
}

function M.config()
end

return M
