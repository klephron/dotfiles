local M = {
  "mfussenegger/nvim-treehopper",
  enabled = false,
  dependencies = {
    "phaazon/hop.nvim",
  },
  config = function()
    local treehopper = require("tsht")
    local funcs = require("utils.funcs")

    treehopper.config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }

    funcs.set_keyremap("o", "m", ":<c-u>lua require('tsht').nodes()<cr>")
    funcs.set_keynomap("x", "m", ":lua require('tsht').nodes()<cr>")
  end
}

return M
