local M = {
  "phaazon/hop.nvim",
  enabled = false,
  config = function()
    local hop = require("hop")
    local funcs = require("utils.funcs")

    hop.setup({
      quit_key = "<Esc>",
      case_insensitive = true,
      jump_on_sole_occurence = true,
      multi_windows = false,
      current_line_only = false,
      create_hl_autocmd = false
    })

    funcs.set_keynomap({ "x", "n", "o" }, 's', function()
      hop.hint_char1({
        direction = nil,
        hint_offset = 0,
        current_line_only = false,
      })
    end, "Hop multiline included")


    funcs.set_keynomap({ "x", "n", "o" }, 't', function()
      hop.hint_char1({
        direction = require("hop.hint").HintDirection.AFTER_CURSOR,
        hint_offset = -1,
        current_line_only = true,
      })
    end, "Hop current line after cursor")
  end
}

return M
