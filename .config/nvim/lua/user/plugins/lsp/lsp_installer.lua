local M = {}

local status_ok, lsp_installer = safe_require("nvim-lsp-installer")
if not status_ok then
  return
end

M.servers = {
  "ccls",
  "sumneko_lua",
  "pyright",
  "bashls",
  "cmake"
}

-- nvim-lsp-installer-default-settings
function M.setup()
  lsp_installer.setup({
    ensure_installed = M.servers,
    install_root_dir = require("nvim-lsp-installer.core.path")
        .concat({ vim.fn.stdpath("data"), "lsp_servers" }),
  })
end

return M
