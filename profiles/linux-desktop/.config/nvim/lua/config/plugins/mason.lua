local M = {
  "williamboman/mason.nvim",
  config = function()
    local mason = require("mason")
    local funcs = require("utils.funcs")

    mason.setup({})

    funcs.set_keynomap("n", "<localleader>ml", "<cmd>MasonLog<cr>", { desc = "Log mason" })
    funcs.set_keynomap("n", "<localleader>mi", "<cmd>Mason<cr>", { desc = "Info mason" })
  end,
}

return M
