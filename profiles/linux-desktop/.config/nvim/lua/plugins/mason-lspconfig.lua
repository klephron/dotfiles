return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    { "williamboman/mason.nvim" },
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local mason_lsp = require("mason-lspconfig")
    local lspconfig = require("plugins.lspconfig")

    mason_lsp.setup({
      ensure_installed = {},
    })

    lspconfig.servers_configure()
    lspconfig.servers_enable()
  end
}
