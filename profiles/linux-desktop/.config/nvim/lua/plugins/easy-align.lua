return {
  "junegunn/vim-easy-align",
  event = "VeryLazy",
  config = function()
    local utils = require("utils")

    utils.set_keynomap("n", "ga", "<Plug>(EasyAlign)", "[easyalign] EasyAlign")
    utils.set_keynomap("x", "ga", "<Plug>(EasyAlign)", "[easyalign] EasyAlign")
  end
}
