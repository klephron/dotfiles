local M = {
  "leath-dub/snipe.nvim",
  opts = {
    ui = {
      position = "cursor"
    },
    hints = {
      dictionary = "asdfqwerzxcvuiopnmtby",
    },
  },
  keys = {
    { "<leader>c", function() require("snipe").open_buffer_menu() end, desc = "Open snipe menu" }
  },
}

return M
