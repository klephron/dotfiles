local M = {}

-- local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

local sources = {
  -- formatting.clang_format,
}

function M.setup()
  require("null-ls").setup({
    debug = false,
    diagnostics_format = "[#{c}] #{m} (#{s})",
    sources = sources,
  })
end

return M
