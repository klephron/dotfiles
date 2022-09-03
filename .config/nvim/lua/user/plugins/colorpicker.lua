return function()

  local kmps = require("user.keymaps").ctrl_i
  us.set_keynomap("i", kmps:key("colorpicker"), "<cmd>PickColorInsert<cr>", kmps:desc("colorpicker"))

  local colorpicker = require("color-picker")
  colorpicker.setup({
    ["border"] = "rounded",
    ["keymap"] = {
    },
    ["background_highlight_group"] = "Normal",
    ["border_highlight_group"] = "FloatBorder",
    ["text_highlight_group"] = "Normal",
  })

  vim.cmd([[hi FloatBorder guibg=NONE]])
end
