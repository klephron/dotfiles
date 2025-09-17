local M = {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require('colorizer').setup({
    }, {
      rgb_fn = true,
      hsl_fn = true,
    })
  end,
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
