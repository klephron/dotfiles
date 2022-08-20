local M = {}

return function()
  local function setup_servers(lspconfig, servers, on_attach, capabilities)
    for _, server in pairs(servers) do
      local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
      }
      local ok, custom_opts = pcall(require, "user.plugins.lsp.servers." .. server)
      if ok then
        opts = vim.tbl_deep_extend("force", opts, custom_opts)
        -- opts = custom_opts
      end
      -- print(us.dump_lua_table(opts))
      lspconfig[server].setup(opts)
    end
  end

  local lspconfig = require("lspconfig")

  local handlers = require("user.plugins.lsp.handlers")
  handlers.setup()

  local servers = require("user.plugins.lsp.servers").servers

  setup_servers(lspconfig, servers, handlers.on_attach, handlers.capabilities)

  require("user.plugins.lsp.null-ls").setup()
  require("user.plugins.lsp.lsp_signature").setup()
  require("user.plugins.lsp.aerial").setup()
  require("user.plugins.lsp.lightbulb").setup()
end
--return M
