local M = {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle" },
  config = function()
    local utils = require("utils.funcs")
    local trouble = require("trouble")
    trouble.setup({
      use_diagnostic_signs = true,
      action_keys = {
        close = "Q"
      }
    })

    utils.augroup("_trouble", {
      {
        event = "FileType",
        pattern = "Trouble",
        command = function()
          utils.set_keynomap("n", "q", function()
            vim.cmd('wincmd p')
            vim.cmd('silent! TroubleClose')
          end, { buffer = 0 })
        end
      },
    })
  end,
  keys = {
    { "<leader>I", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "trouble: toggle workspace" },
    { "<leader>i", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "trouble: toggle document" },
  }
}

return M
