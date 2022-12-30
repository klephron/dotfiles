local M = {
  'nvim-telescope/telescope.nvim',
  config = function()
    local telescope = require("telescope")
    telescope.setup()
  end
}

return M
