local setup_options
local fetch_options

local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
  },
  _options = nil,
  config = function()
    local diagnostics = p_require("lsp.diagnostics")
    local servers = p_require("lsp.servers")

    local lspconfig = require("lspconfig")
    local options = fetch_options()

    -- Setup diagnostics
    diagnostics.setup()
    -- Setup servers
    for server, opts in pairs(servers) do
      opts = vim.tbl_deep_extend("force", {}, options, opts or {})
      lspconfig[server].setup(opts)
    end
  end
}

setup_options = function()
  local formatting = p_require("lsp.formatting")
  local keymaps = p_require("lsp.keymaps")

  local cmp_nvim_lsp = require("cmp_nvim_lsp")

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

  local function on_attach(client, bufnr)
    formatting.on_attach(client, bufnr)
    keymaps.on_attach(client, bufnr)
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

  M._options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    handlers = handlers
  }
end

fetch_options = function()
  if M._options == nil then
    setup_options()
  end
  return M._options
end

M.fetch_options = fetch_options

return M
