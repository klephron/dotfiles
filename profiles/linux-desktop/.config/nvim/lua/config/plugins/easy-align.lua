local M = {
  "junegunn/vim-easy-align",
  event = "VeryLazy",
  config = function()
    local funcs = require("utils.funcs")
    funcs.set_keynomap("n", "ga", "<Plug>(EasyAlign)")
    funcs.set_keynomap("x", "ga", "<Plug>(EasyAlign)")
  end
}

return M
