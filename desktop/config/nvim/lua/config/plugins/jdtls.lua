local M = {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  config = function()
    local funcs = require("utils.funcs")
    local jdtls = require("jdtls")

    local fetch_options = require("config.plugins.lspconfig").fetch_options
    local on_attach = require("config.plugins.lspconfig").on_attach

    local server_options = require("config.plugins.lsp.servers").jdtls
    server_options = vim.tbl_deep_extend("force", {}, fetch_options(), server_options or {})

    local server_on_attach = server_options.on_attach

    server_options.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      server_on_attach(client, bufnr)
    end

    funcs.augroup("local_jdtls", {
      {
        event = { "BufRead", "BufNewFile" },
        pattern = "*.java",
        command = function()
          jdtls.start_or_attach(server_options)
        end,
      }
    })
  end
}

return M
