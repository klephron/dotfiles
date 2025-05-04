local M = {
  "williamboman/mason.nvim",
  config = function()
    local mason = require("mason")
    local funcs = require("utils.funcs")

    mason.setup({})

    funcs.set_keynomap("n", "<localleader>ml", "<cmd>MasonLog<cr>", { desc = "Log" })
    funcs.set_keynomap("n", "<localleader>ms", "<cmd>Mason<cr>", { desc = "Info" })
  end,
}

return M
