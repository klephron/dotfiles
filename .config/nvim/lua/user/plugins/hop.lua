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

  us.set_keynomap({"x", "n", "o"}, 's', function ()
    hop.hint_char1({
      direction = nil,
      hint_offset = 0,
      current_line_only = false,
    })
  end, "hop: Move multiline included")

  us.set_keynomap({"x", "n", "o"}, 'F', function ()
    hop.hint_char1({
      direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
      hint_offset = 0,
      current_line_only = true,
    })
  end, "hop: Move current line before cursor included")
  us.set_keynomap({"x", "n", "o"}, 'f', function ()
    hop.hint_char1({
      direction = require("hop.hint").HintDirection.AFTER_CURSOR,
      hint_offset = 0,
      current_line_only = true,
    })
  end, "hop: Move current line after cursor included")
  us.set_keynomap({"x", "n", "o"}, 'T', function ()
    hop.hint_char1({
      direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
      hint_offset = 1,
      current_line_only = true,
    })
  end, "hop: Move current line before cursor excluded")
  us.set_keynomap({"x", "n", "o"}, 't', function ()
    hop.hint_char1({
      direction = require("hop.hint").HintDirection.AFTER_CURSOR,
      hint_offset = -1,
      current_line_only = true,
    })
  end, "hop: Move current line after cursor excluded")
end
