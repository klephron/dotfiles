return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  config = function()
    local utils = require("utils")
    local jdtls = require("jdtls")
    local lspconfig = require("plugins.lspconfig")

    local server_options = vim.tbl_deep_extend("force", {},
      lspconfig.options_fetch(),
      lspconfig.servers_options.jdtls or {}
    )

    server_options.on_attach = function(client, bufnr)
      lspconfig.on_attach(client, bufnr)
      server_options.on_attach(client, bufnr)
    end

    utils.augroup("p.jdtls", {
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
