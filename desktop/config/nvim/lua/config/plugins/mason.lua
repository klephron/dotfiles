local M = {
  "williamboman/mason.nvim",
  config = function()
    local mason = require("mason")
    local funcs = require("utils.funcs")

    mason.setup({})

    local tools = {
      "black",
      "stylua",
    }

    local registry = require("mason-registry")

    for _, tool in ipairs(tools) do
      local p = registry.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end

    funcs.set_keynomap("n", "<localleader>ml", "<cmd>MasonLog<cr>", {desc="Log"})
    funcs.set_keynomap("n", "<localleader>ms", "<cmd>Mason<cr>", {desc="Info"})

  end,
}

return M
