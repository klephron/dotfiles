local M = {
  "norcalli/nvim-colorizer.lua",
  opts = {},
  keys = {
    {
      "<localleader>c",
      "<cmd>ColorizerToggle<cr>",
      mode = "n",
      desc = "Toggle buffer colorizer"
    },
  }
}

return M
