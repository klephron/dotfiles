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

    local lspconfig = require("lspconfig")
    local plugin_lspconfig = require("config.plugins.lspconfig")
    local options = plugin_lspconfig.fetch_options()

    mason_lsp.setup_handlers({
      function(server)
        lspconfig[server].setup(options)
      end
    })

    -- override
    plugin_lspconfig.setup_servers()
  end
}

return M
