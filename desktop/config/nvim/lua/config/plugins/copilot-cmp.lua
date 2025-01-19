local M = {
  "zbirenbaum/copilot-cmp",
  enabled = false,
  config = function()
    require("copilot_cmp").setup()
  end
}

return M
