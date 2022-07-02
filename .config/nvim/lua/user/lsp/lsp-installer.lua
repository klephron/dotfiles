local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "ccls",
}

lsp_installer.setup {
  ensure_installed = servers,
  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = false,
  icons = {
      server_installed = "◍",
      server_pending = "◍",
      server_uninstalled = "◍",
  },
  ui = {
    check_outdated_servers_on_open = true,
    border = "none",
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
    },
  },
  install_root_dir = require("nvim-lsp-installer.core.path").concat { vim.fn.stdpath("data"), "lsp_servers" },
  log_level = vim.log.levels.INFO,
}


local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

