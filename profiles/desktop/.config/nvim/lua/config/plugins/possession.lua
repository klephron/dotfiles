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
        on_load = true,
        on_quit = true,
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
      plugins = {
        delete_hidden_buffers = false,
      },
      telescope = {
        list = {
          default_action = 'load',
          mappings = {
            save = { n = '<c-s>', i = '<c-s>' },
            load = { n = '<c-l>', i = '<c-l>' },
            delete = { n = '<c-d>', i = '<c-d>' },
            rename = { n = '<c-r>', i = '<c-r>' },
          },
        },
      },
    })
  end,
  keys = {
    { "<leader>V",  "<cmd>Telescope possession list<cr>", desc = "possession: Search session" },
    { "<leader>vd", "<cmd>PossessionDelete<cr>",          desc = "possession: Delete current session" },
    { "<leader>vl", "<cmd>PossessionLoad<cr>",            desc = "possession: Load session" },
    { "<leader>vr", "<cmd>PossessionRename<cr>",          desc = "possession: Rename session" },
    {
      "<leader>vs",
      function()
        vim.cmd("PossessionSave!")
      end,
      desc = "possession: Save session"
    },
    {
      "<leader>vS",
      function()
        vim.ui.input({ prompt = "Enter session name: ", },
          function(str)
            if str then
              vim.cmd("PossessionSave " .. str)
            end
          end
        )
      end,
      desc = "possession: Save session with name"
    },
  }
}

return M
