local M = {
  "lukas-reineke/indent-blankline.nvim",
  enabled = true,
  config = function()
    require("ibl").setup {
      indent = {
        char = '│'
      },
      scope = {
        enabled = false,
      }
    }
  end
}

return M
