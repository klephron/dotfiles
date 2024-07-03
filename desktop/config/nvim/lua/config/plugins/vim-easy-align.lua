local M = {
  "junegunn/vim-easy-align",
  event = "UIEnter",
  config = function()
    local utils = u_require("funcs")
    utils.set_keynomap("n", "ga", "<Plug>(EasyAlign)")
    utils.set_keynomap("x", "ga", "<Plug>(EasyAlign)")
  end
}

return M
