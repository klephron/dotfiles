local M = {
  "williamboman/mason.nvim",
}

M.tools = {
  "black",
  "stylua",
}

function M.check()
  local mr = require("mason-registry")
  for _, tool in ipairs(M.tools) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end

function M.config()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")

  mason.setup({})
  M.check()

  mason_lspconfig.setup({
    automatic_installation = true,
  })
end

return M
