local M = {
  "zbirenbaum/copilot-cmp",
  enabled = true,
  config = function()
    require("copilot_cmp").setup()
  end
}

return M
