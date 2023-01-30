local M = {
  "junegunn/vim-easy-align",
  event = "UIEnter",
  config = function()
    us.set_keynomap("n", "ga", "<Plug>(EasyAlign)")
    us.set_keynomap("x", "ga", "<Plug>(EasyAlign)")

    vim.cmd("cnoreabbrev ea EasyAlign")
  end
}

return M
