return {
  "onsails/lspkind.nvim",
  lazy = true,
  config = function()
    local lspkind = require("lspkind")

    lspkind.init({
      mode = 'symbol',
      preset = 'default',
      symbol_map = {
        Copilot = "",
      },
    })
  end
}
