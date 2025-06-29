local M = {
  'nvimtools/none-ls.nvim',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local funcs = require("utils.funcs")
    local null_ls = require("null-ls")
    local lspconfig = require("config.plugins.lspconfig")
    local options = lspconfig.fetch_options()

    local code_actions = null_ls.builtins.code_actions
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting
    local completion = null_ls.builtins.completion
    local hover = null_ls.builtins.hover

    local sources = {
      formatting.prettier,
      formatting.black,

      -- diagnostics.mypy.with { extra_args = { "--strict" } },
      diagnostics.mypy,
      diagnostics.protolint,
    }


    null_ls.setup({
      debounce = options.flags.debounce,
      save_after_format = false,
      debug = false,
      on_attach = lspconfig.on_attach,
      diagnostics_format = "[#{c}] #{m} (#{s})",
      sources = sources
    })

    funcs.set_keynomap("n", "<localleader>ul", "<cmd>NullLsLog<cr>", "Log null-ls")
    funcs.set_keynomap("n", "<localleader>us", "<cmd>NullLsInfo<cr>", "Info null-ls")
  end,
}

return M
