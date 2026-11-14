return {
  'nvimtools/none-ls.nvim',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local utils = require("utils")
    local null_ls = require("null-ls")

    local lspconfig = require("plugins.lspconfig")
    local lspconfig_options = lspconfig.options_fetch()

    local builtins = null_ls.builtins

    null_ls.setup({
      debounce = lspconfig_options.flags.debounce,
      save_after_format = false,
      debug = false,
      on_attach = lspconfig.on_attach,
      diagnostics_format = "[#{c}] #{m} (#{s})",
      sources = {
        builtins.formatting.black.with({
        }),
        builtins.formatting.prettier.with({
        }),

        builtins.diagnostics.mypy.with({
          -- extra_args = { "--strict" },
        }),
        builtins.diagnostics.protolint.with({
        }),
      }
    })

    utils.set_keynomap("n", "<localleader>nl", "<cmd>NullLsLog<cr>", "[null-ls] Open logs")
    utils.set_keynomap("n", "<localleader>ns", "<cmd>NullLsInfo<cr>", "[null-ls] Info")
  end,
}
