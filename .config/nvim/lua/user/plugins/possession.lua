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
      }
    })
  end
}

return M
