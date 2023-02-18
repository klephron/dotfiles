local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "jose-elias-alvarez/null-ls.nvim" },
  }
}

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    width = 60,
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    width = 60,
  })
}

function M.config()
  local diagnostics = conf_require("lsp.sfn.diagnostics")
  local formatting = conf_require("lsp.sfn.formatting")
  local keymaps = conf_require("lsp.sfn.keymaps")
  local servers = conf_require("lsp.sfn.servers")

  local conf_null_ls = conf_require("lsp.null-ls")

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
    },
    handlers = handlers
  }
  -- Setup diagnostics
  diagnostics.setup()
  -- Setup servers
  for server, opts in pairs(servers) do
    opts = vim.tbl_deep_extend("force", {}, options, opts or {})
    lspconfig[server].setup(opts)
  end
  -- Setup dependencies
  conf_null_ls.manual_config(options)
end

return M
