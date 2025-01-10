local M = {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  enabled = false,
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end
}

return M
