local M = {
  "junegunn/vim-easy-align",
  event = "UIEnter",
  config = function()
    config.set_keynomap("n", "ga", "<Plug>(EasyAlign)")
    config.set_keynomap("x", "ga", "<Plug>(EasyAlign)")
  end
}

return M
