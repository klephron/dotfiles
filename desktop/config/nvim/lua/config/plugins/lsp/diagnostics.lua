local M = {}

local icons = require("config.icons").diagnostics

M.signs = {
  Error = icons.error,
  Warn = icons.warn,
  Hint = icons.hint,
  Info = icons.info
}

function M.setup()
  vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    -- virtual_text = { spacing = 2, prefix = "●", format = function(diagnostic)
    --   local STR_MAX_SIZE = 30
    --   local mes = string.format("%s", diagnostic.message)
    --   if mes:len() > STR_MAX_SIZE then
    --     return mes:sub(1, STR_MAX_SIZE - 3) .. "..."
    --   end
    --   return mes
    -- end
    -- },
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    }
  })

  for type, icon in pairs(M.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { texthl = hl, text = icon, numhl = "" })
  end
end

function M.on_attach(client, bufnr)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true, { bufnr })
  end
end

return M
