local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { 'jose-elias-alvarez/null-ls.nvim' },
  }
}

function M.config()
  local diagnostics = conf_require("lsp.diagnostics")
  local formatting = conf_require("lsp.formatting")
  local keymaps = conf_require("lsp.keymaps")
  local servers = conf_require("lsp.servers")

  local lspconfig = require("lspconfig")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")

  local function on_attach(client, bufnr)
    formatting.on_attach(client, bufnr)
    keymaps.on_attach(client, bufnr)
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

  local options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }

  for server, opts in pairs(servers) do
    opts = vim.tbl_deep_extend("force", {}, options, opts or {})
    lspconfig[server].setup(opts)
  end

  conf_require("lsp.null-ls").setup(options)
end

return M
