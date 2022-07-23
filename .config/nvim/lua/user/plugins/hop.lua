return function()
  local hop = require("hop")
  hop.setup {
    keys = 'etovxqpdygfbzcisuran',
    quit_key = "<Esc>",
    case_insensitive = true,
    jump_on_sole_occurence = true,
    multi_windows = false,
    current_line_only = false,
    -- teasing = false,
  }

  us.set_keynomap("xno", 's', function ()
    hop.hint_char1({
      direction = nil,
      hint_offset = 0,
      current_line_only = false,
    })
  end)

  us.set_keynomap("xno", 'F', function ()
    hop.hint_char1({
      direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
      hint_offset = 0,
      current_line_only = true,
    })
  end)
  us.set_keynomap("xno", 'f', function ()
    hop.hint_char1({
      direction = require("hop.hint").HintDirection.AFTER_CURSOR,
      hint_offset = 0,
      current_line_only = true,
    })
  end)
  us.set_keynomap("xno", 'T', function ()
    hop.hint_char1({
      direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
      hint_offset = 1,
      current_line_only = true,
    })
  end)
  us.set_keynomap("xno", 't', function ()
    hop.hint_char1({
      direction = require("hop.hint").HintDirection.AFTER_CURSOR,
      hint_offset = -1,
      current_line_only = true,
    })
  end)
end
