local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "ccls",
  "sumneko_lua",
  "pyright",
  "bashls",
  "cmake"
}

-- nvim-lsp-installer-default-settings
lsp_installer.setup({
  ensure_installed = servers,
  install_root_dir = require("nvim-lsp-installer.core.path")
                            .concat({ vim.fn.stdpath("data"), "lsp_servers" }),
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

for _, server in pairs(servers) do
  local opts = {
    on_attach = require("user.plugins.lsp.handlers").on_attach,
    capabilities = require("user.plugins.lsp.handlers").capabilities,
  }
  local ok, custom_opts = pcall(require, "user.plugins.lsp.servers." .. server)
  if ok then
    opts = vim.tbl_deep_extend("force", opts, custom_opts)
  end
  lspconfig[server].setup(opts)
end

