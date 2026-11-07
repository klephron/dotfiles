return {
  "mfussenegger/nvim-treehopper",
  enabled = false,
  dependencies = {
    "phaazon/hop.nvim",
  },
  config = function()
    local treehopper = require("tsht")
    local utils = require("utils")

    treehopper.config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }

    utils.set_keyremap("o", "m", ":<c-u>lua require('tsht').nodes()<cr>")
    utils.set_keynomap("x", "m", ":lua require('tsht').nodes()<cr>")
  end
}
