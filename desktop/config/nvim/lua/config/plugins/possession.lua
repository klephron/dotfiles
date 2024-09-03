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
          if vim.fn.exists(":Neotree") > 0 then vim.cmd("tabdo Neotree close") end
          if vim.fn.exists(":AerialCloseAll") > 0 then vim.cmd("tabdo AerialCloseAll") end
          return {}
        end,
        before_load = function(_, user_data)
          if vim.fn.exists(":Neotree") > 0 then vim.cmd("tabdo Neotree close") end
          if vim.fn.exists(":AerialCloseAll") > 0 then vim.cmd("tabdo AerialCloseAll") end
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
  end,
  keys = {
    { "<leader>V", "<cmd>Telescope possession list<cr>", desc = "possession: Search session" },
    { "<leader>v", "<cmd>PossessionLoad<cr>",            desc = "possession: Restore current session" },
  }
}

return M
