local M = {}

function M.setup()
  local kmps = require("user.keymaps").neorg

  local function cmd(str)
    return "<cmd>" .. str .. "<cr>"
  end

  local function load_wrapper(callback)
    return function()
      if not require("neorg").is_loaded() then
        vim.cmd("NeorgStart")
        vim.notify('Loaded.', vim.log.levels.INFO, { title = 'Neorg' })
      end
      if type(callback) == 'function' then return callback()
      elseif type(callback) == 'string' then return vim.cmd(callback) end
    end
  end

  us.set_keynomap("n", kmps.gtd_capture.key, load_wrapper("Neorg gtd capture"), kmps:desc("gtd_capture"))
  us.set_keynomap("n", kmps.gtd_views.key, load_wrapper("Neorg gtd views"), kmps:desc("gtd_views"))
  us.set_keynomap("n", kmps.kanban_toggle.key, load_wrapper("Neorg kanban toggle"), kmps:desc("kanban_toggle"))
  us.set_keynomap("n", kmps.switch_workspace.key, load_wrapper("Telescope neorg switch_workspace"),
    kmps:desc("switch_workspace"))
  us.set_keynomap("n", kmps.journal.key, load_wrapper("Neorg journal"), kmps:desc("journal"))
end

function M.config()
  local neorg = require("neorg")
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

return M
