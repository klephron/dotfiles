return function()
  local mason = require("mason")
  local lspinstaller = require("mason-lspconfig")

  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })


  lspinstaller.setup({
    ensure_installed = plug_require("lsp.servers").servers,
    automatic_installation = false,
  })

end
