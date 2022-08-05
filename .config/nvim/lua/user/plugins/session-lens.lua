return function()
  local session_lens = require("session-lens")

  session_lens.setup {
    -- pass telescope options
    path_display = {
      shorten = { len = 1, exclude = { 3, -1 } },
      "hidden",
      "truncate",
    },
    -- layout_strategy = "flex",
    prompt_title = 'Sessions',
    previewer = false,
    -- theme_conf = nil,
  }

  require('telescope').load_extension("session-lens")

end
