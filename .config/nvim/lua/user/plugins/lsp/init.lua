return function()
  local lspconfig = require("lspconfig")
  local lsp_signature = require("lsp_signature")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")

  local handlers = plug_require("lsp.handlers")
  local servers = plug_require("lsp.servers").servers
  local lsp_null_ls = plug_require("lsp.null-ls")


  local function on_attach(client, bufnr)
    handlers.attach_keymaps(client, bufnr)
    handlers.attach_highlights(client, bufnr)
    lsp_signature.on_attach()
  end


  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

  local options = {
    on_attach = on_attach,
    capabilities = handlers.capabilities,
  }

  -- Setup lsp servers
  for _, server in pairs(servers) do
    local opts = options
    local ok, custom_opts = pcall(plug_require, "lsp.servers." .. server)
    if ok then
      opts = vim.tbl_deep_extend("force", options, custom_opts)
    end
    lspconfig[server].setup(opts)
  end

  handlers.setup()
  lsp_null_ls.setup(options)
end
