local M = {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  config = function()
    local funcs = require("utils.funcs")
    local jdtls = require("jdtls")

    local options_fetch = require("config.plugins.lspconfig").options_fetch
    local on_attach = require("config.plugins.lspconfig").on_attach

    local server_options = vim.tbl_deep_extend("force", {}, options_fetch(),
      require("config.plugins.lsp.servers").jdtls or {})

    local server_on_attach = server_options.on_attach

    server_options.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      server_on_attach(client, bufnr)
    end

    funcs.augroup("local_jdtls", {
      {
        event = { "FileType" },
        pattern = "java",
        command = function()
          jdtls.start_or_attach(server_options)
        end,
      }
    })

    -- force trigger because plugin is loaded on filetype
    jdtls.start_or_attach(server_options)
  end
}

return M
