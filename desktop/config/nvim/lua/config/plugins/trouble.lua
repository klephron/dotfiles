local M = {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle" },
  config = function()
    local trouble = require("trouble")
    trouble.setup({
      use_diagnostic_signs = true,
      action_keys = {
        close = "Q"
      }
    })

    config.augroup("_trouble", {
      {
        event = "FileType",
        pattern = "Trouble",
        command = function()
          config.set_keynomap("n", "q", function()
            vim.cmd('wincmd p')
            vim.cmd('silent! TroubleClose')
          end, { buffer = 0 })
        end
      },
    })
  end
}

return M
