local M = {
  "leath-dub/snipe.nvim",
  keys = {
    { "<leader>c", function() require("snipe").open_buffer_menu() end, desc = "Open snipe menu" }
  },
  opts = {
    ui = {
      position = "cursor"
    },
    hints = {
      dictionary = "asdfqwerzxcvuiopnmtby",
    },
  }
}

return M
