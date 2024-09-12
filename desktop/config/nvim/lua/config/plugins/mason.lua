local M = {
  "williamboman/mason.nvim",
  config = function()
    local mason = require("mason")
    local funcs = require("utils.funcs")

    mason.setup({})

    local tools = {
      "lua-language-server",
    }

    funcs.set_keynomap("n", "<localleader>ml", "<cmd>MasonLog<cr>", {desc="Log"})
    funcs.set_keynomap("n", "<localleader>ms", "<cmd>Mason<cr>", {desc="Info"})

    local registry = require("mason-registry")

    registry.refresh(function ()
      for _, tool in ipairs(tools) do
        local p = registry.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end)

  end,
}

return M
