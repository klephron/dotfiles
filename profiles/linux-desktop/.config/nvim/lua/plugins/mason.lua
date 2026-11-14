return {
  "williamboman/mason.nvim",
  config = function()
    local mason = require("mason")
    local utils = require("utils")

    mason.setup({})

    utils.set_keynomap("n", "<localleader>ml", "<cmd>MasonLog<cr>", { desc = "[mason] Show logs" })
    utils.set_keynomap("n", "<localleader>ms", "<cmd>Mason<cr>", { desc = "[mason] Info" })
    utils.set_keynomap("n", "<localleader>mu", "<cmd>MasonUpdate<cr>", { desc = "[mason] Update registries" })
  end,
}
