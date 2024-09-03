local setup_options
local fetch_options

local M = {
  'neovim/nvim-lspconfig',
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
  },
  _options = nil,
  config = function()
    local diagnostics = require("config.plugins.lsp.diagnostics")
    local servers = require("config.plugins.lsp.servers")

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
  local formatting = require("config.plugins.lsp.formatting")
  local keymaps = require("config.plugins.lsp.keymaps")

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

---@return table
fetch_options = function()
  if M._options == nil then
    setup_options()
  end
  return M._options
end

M.fetch_options = fetch_options

return M
