local M = {
  'nvimtools/none-ls.nvim',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local funcs = require("utils.funcs")
    local null_ls = require("null-ls")
    local lspconfig = require("config.plugins.lspconfig")

    local options = lspconfig.options_fetch()
    local builtins = null_ls.builtins

    local sources = {
      builtins.formatting.prettier,
      builtins.formatting.black,

      -- builtins.diagnostics.mypy.with { extra_args = { "--strict" } },
      builtins.diagnostics.mypy,
      builtins.diagnostics.protolint,
    }


    null_ls.setup({
      debounce = options.flags.debounce,
      save_after_format = false,
      debug = false,
      on_attach = lspconfig.on_attach,
      diagnostics_format = "[#{c}] #{m} (#{s})",
      sources = sources
    })

    funcs.set_keynomap("n", "<localleader>nl", "<cmd>NullLsLog<cr>", "Log null-ls")
    funcs.set_keynomap("n", "<localleader>ns", "<cmd>NullLsInfo<cr>", "Info null-ls")
  end,
}

return M
