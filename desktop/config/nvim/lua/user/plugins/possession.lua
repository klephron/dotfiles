local M = {
  "jedrzejboczar/possession.nvim",
  cmd = { "PossessionLoad", "PossessionSave", "PossessionRename", "PossessionClose", "PossessionDelete",
    "PossessionShow", "PossessionList", "PossessionMigrate" },
  enabled = true,
  config = function()
    local possession = require("possession")
    possession.setup({
      autosave = {
        current = true,
      },
      hooks = {
        before_save = function(_)
          vim.cmd("tabdo Neotree close")
          vim.cmd("tabdo AerialCloseAll")
          return {}
        end,
        before_load = function(_, user_data)
          vim.cmd("tabdo Neotree close")
          vim.cmd("tabdo AerialCloseAll")
          return user_data
        end
      },
      telescope = {
        list = {
          default_action = 'load',
          mappings = {
            save = { n = '<c-s>', i = '<c-s>' },
            load = { n = '<c-l>', i = '<c-l>' },
            delete = { n = '<c-f>', i = '<c-f>' },
            rename = { n = '<c-r>', i = '<c-r>' },
          },
        },
      },
    })
  end
}

return M
