local M = {
  "mfussenegger/nvim-jdtls",
  config = function()
    local funcs = require("utils.funcs")

    funcs.augroup("local_jdtls", {
      {
        event = { "BufRead", "BufNewFile" },
        pattern = "*.java",
        command = function()
          local server_options = require("config.plugins.lsp.servers").jdtls
          local options = require("config.plugins.lspconfig").fetch_options()

          server_options = vim.tbl_deep_extend("force", {}, options, server_options or {})

          require("jdtls").start_or_attach(server_options)
        end,
      }
    })
  end
}

return M
