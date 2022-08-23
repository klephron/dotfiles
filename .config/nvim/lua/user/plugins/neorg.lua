return function()
  local neorg = require("neorg")
  local kmps = require("user.keymaps").neorg
  local neorg_started = false

  us.set_keynomap("n", kmps.gtd_capture.key, "<cmd>Neorg gtd capture<cr>", kmps:desc("gtd_capture"))
  us.set_keynomap("n", kmps.gtd_views.key, "<cmd>Neorg gtd views<cr>", kmps:desc("gtd_views"))
  us.set_keynomap("n", kmps.kanban_toggle.key, "<cmd>Neorg kanban toggle<cr>", kmps:desc("kanban_toggle"))
  us.set_keynomap("n", kmps.switch_workspace.key, "<cmd>Telescope neorg switch_workspace<cr>",
    kmps:desc("switch_workspace"))
  us.set_keynomap("n", kmps.neorg_start.key, function()
    if not neorg_started then
      vim.cmd("NeorgStart")
      vim.notify('Loaded.', vim.log.levels.INFO, { title = 'Neorg' })
      neorg_started = true
    else
      vim.notify('Already Loaded.', vim.log.levels.INFO, { title = 'Neorg' })
    end
  end, kmps:desc("neorg_start"))
  us.set_keynomap("n", kmps.journal.key, "<cmd>Neorg journal<cr>", kmps:desc("journal"))

  neorg.setup {
    load = {
      ["core.defaults"] = {}, -- https://github.com/nvim-neorg/neorg/wiki#default-modules
      ["core.keybinds"] = {
        config = {
          default_keybinds = true,
          neorg_leader = "<localleader>",
          hook = function(keybinds)
            -- todo lists
            keybinds.unmap("norg", "n", "<C-Space>")
            -- telescope
            keybinds.map_event("norg", "i", "<C-u>", "core.integrations.telescope.insert_link")
            keybinds.map_event("norg", "n", "<C-s>", "core.integrations.telescope.find_linkable")
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
          open_last_workspace = false,
        }
      },
      ["core.norg.concealer"] = {},
      ["core.norg.completion"] = {
        config = {
          engine = "nvim-cmp",
        }
      },
      ["core.norg.qol.toc"] = {},
      ['core.gtd.base'] = {
        config = {
          workspace = 'tasks',
        },
      },
      ['core.norg.journal'] = {
        config = {
          workspace = 'tasks',
        }
      },
      ["core.integrations.telescope"] = {},
      ['external.kanban'] = {},
    }
  }
end
