local M = {
  "glepnir/lspsaga.nvim",
  enabled = false,
  config = function()
    local lspsaga = require("lspsaga")
    lspsaga.init_lsp_saga({
      border_style = "rounded",
      code_action_icon = require("config.icons").diagnostics.lightbulb,
      code_action_lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        enable = false,
      },
      code_action_keys = {
        quit = "q",
        exec = "<CR>",
      },
    })
  end
}

return M
