local M = {}

local icons = require("user.icons").diagnostics

M.signs = {
  Error = icons.error,
  Warn = icons.warn,
  Hint = icons.hint,
  Info = icons.info
}

function M.setup()
  vim.diagnostic.config({
    underline = true,
    -- virtual_text = { spacing = 4, prefix = "●" },
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
    }
  })

  for type, icon in pairs(M.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { texthl = hl, text = icon, numhl = "" })
  end
end

return M
