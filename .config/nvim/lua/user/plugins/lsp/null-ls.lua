local status_ok, null_ls = safe_require("null-ls")
if not status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
  -- formatting.clang_format,
}

null_ls.setup({
  debug = false,
  diagnostics_format = "[#{c}] #{m} (#{s})",
  sources = sources,
})
