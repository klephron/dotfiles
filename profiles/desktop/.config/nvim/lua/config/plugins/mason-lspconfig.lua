local M = {
  "williamboman/mason-lspconfig.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim" },
  },
  config = function()
    local mason_lsp = require("mason-lspconfig")

    mason_lsp.setup({
      ensure_installed = {},
    })

    local plugin_lspconfig = require("config.plugins.lspconfig")

    mason_lsp.setup({
    })

    -- override
    plugin_lspconfig.servers_config()
    plugin_lspconfig.servers_enable()
  end
}

return M
