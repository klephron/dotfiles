local M = {
  'nvim-telescope/telescope.nvim',
}

function M.config()
  local telescope = require("telescope")
  telescope.setup()
end

return M
