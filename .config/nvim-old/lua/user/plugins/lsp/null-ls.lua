local M = {}

function M.setup(options)
  local null_ls = require("null-ls")

  local code_actions = null_ls.builtins.code_actions
  local diagnostics = null_ls.builtins.diagnostics
  local formatting = null_ls.builtins.formatting
  local completion = null_ls.builtins.completion
  local hover = null_ls.builtins.hover

  local sources = {
    -- python
    diagnostics.pylint,
    diagnostics.mypy.with { extra_args = {"--strict"} },
    formatting.black,
  }

  null_ls.setup({
    debug = false,
    debounce = 150,
    save_after_format = false,
    diagnostics_format = "[#{c}] #{m} (#{s})",
    sources = sources,
    on_attach = options.on_attach
  })
end

return M
