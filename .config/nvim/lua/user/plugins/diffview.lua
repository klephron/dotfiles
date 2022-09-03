local M = {}
M.setup = function()
  local kmps = require("user.keymaps").git
  us.set_keynomap("n", kmps.diffview_open.key, '<cmd>DiffviewOpen<cr>', kmps:desc("diffview_open"))
  us.set_keynomap("n", kmps.diffview_history.key, '<cmd>DiffviewFileHistory<cr>', kmps:desc("diffview_history"))
end

M.config = function()
  local diffview = require("diffview")
  diffview.setup({

  })
end

return M
