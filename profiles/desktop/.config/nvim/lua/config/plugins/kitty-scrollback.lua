local M = {
  'mikesmithgh/kitty-scrollback.nvim',
  enabled = true,
  lazy = true,
  cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
  event = { 'User KittyScrollbackLaunch' },
  version = '*',
  config = function()
    local funcs = require("utils.funcs")

    require('kitty-scrollback').setup({
      {
        keymaps_enabled = true,
        status_window = {
          style_simple = false,
          autoclose = false,
        },
        paste_window = {
          hide_footer = true,
          yank_register_enabled = false,
        },
      },
    })

    -- funcs.set_keynomap("n", "<leader>t", "<Plug>(KsbToggleFooter)")
  end,
}

return M
