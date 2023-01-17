local M = {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
}

function M.config()
  local dv = require("diffview")
  dv.setup({
  })
end

return M
