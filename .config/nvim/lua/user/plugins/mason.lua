local M = {
  "williamboman/mason.nvim",
  config = function()
    local mason = require("mason")
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
  end
}

return M
