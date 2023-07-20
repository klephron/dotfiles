local M = {
  "williamboman/mason.nvim",
}

local tools = {
  "black",
  "stylua",
}


local function check()
  local registry = require("mason-registry")

  for _, tool in ipairs(tools) do
    local p = registry.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end

function M.config()
  local mason = require("mason")
  mason.setup({})
  check()
end

return M
