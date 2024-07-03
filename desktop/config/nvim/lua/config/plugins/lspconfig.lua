local lspconfig_get_options
local lspconfig_set_options

local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
  },
  options = nil,
  config = function()
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "single",
        width = 60,
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
        width = 60,
      })
    }

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
    -- For setuping others plugins
    lspconfig_set_options(options)
  end
}

lspconfig_get_options = function()
  return M.options
end

lspconfig_set_options = function(options)
  M.options = options
end

M.lspconfig_get_options = lspconfig_get_options
M.lspconfig_set_options = lspconfig_set_options

return M
