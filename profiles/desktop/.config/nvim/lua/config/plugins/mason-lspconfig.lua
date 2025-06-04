local M = {
  "williamboman/mason-lspconfig.nvim",
  event = "VeryLazy",
  dependencies = {
    { "williamboman/mason.nvim" },
  },
  config = function()
    local mason_lsp = require("mason-lspconfig")

    mason_lsp.setup({
      ensure_installed = { "lua_ls" },
    })

    local plugin_lspconfig = require("config.plugins.lspconfig")

    mason_lsp.setup({
    })

    -- override
    plugin_lspconfig.config_servers()
  end
}

return M
