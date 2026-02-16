local M = {
  "onsails/lspkind.nvim",
  config = function()
    local lspkind = require("lspkind")
    lspkind.init({
      mode = 'symbol',
      preset = 'default',
      symbol_map = {
        Copilot = "",
      },
    })
    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
  end
}

return M
