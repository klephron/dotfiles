local M = {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  enabled = true,
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end
}

return M
