return function()
  local lspsaga = require("lspsaga")
  lspsaga.init_lsp_saga({
    border_style = "rounded",
    code_action_icon = require("user.icons").diagnostics.lightbulb,
    code_action_lightbulb = {
      enable = false,
    },
    code_action_keys = {
      quit = "q",
      exec = "<CR>",
    },
  })

  vim.cmd("hi clear LspSagaLightBulb")
  vim.cmd("hi LspSagaLightBulb guifg=Yellow")
end
