return function()
  local neorg = require("neorg")

  neorg.setup {
    load = {
      ["core.defaults"] = {}, -- https://github.com/nvim-neorg/neorg/wiki#default-modules
      ["core.keybinds"] = {
        config = {
          default_keybinds = true,
          neorg_leader = "<localleader>",
          hook = function(keybinds)

          end
        },
      },
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            notes = "~/Workspace/neorg/notes",
            tasks = "~/Workspace/neorg/tasks",
          },
          index = "index.norg",
        }
      },
      ["core.norg.concealer"] = {},
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        }
      },
      ["core.norg.qol.toc"] = {},
      ["core.integrations.telescope"] = {},
      ['core.gtd.base'] = {
        config = {
          workspace = 'tasks',
        },
      },
    }
  }
end
