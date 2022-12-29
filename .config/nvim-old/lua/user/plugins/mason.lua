return function()
  local mason = require("mason")
  local lspinstaller = require("mason-lspconfig")

  local lspservers = plug_require("lsp.servers")

  local servers = vim.tbl_extend("keep", lspservers, {
    "pylint",
  })

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
    ensure_installed = servers,
    automatic_installation = false,
  })

end
