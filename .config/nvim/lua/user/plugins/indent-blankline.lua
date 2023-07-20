local M = {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("indent_blankline").setup {
      space_char_blankline = " ",
      show_current_context = false,
      show_current_context_start = false,
    }
  end
}

return M
