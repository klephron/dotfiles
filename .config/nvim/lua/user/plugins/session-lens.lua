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
    prompt_title = 'SESSIONS',
    previewer = false,
    -- theme_conf = nil,
  }

  require('telescope').load_extension("session-lens")

  us.set_keynomap("n", "<leader>s", "<cmd>lua require('session-lens').search_session()<cr>",
    "telescope: Recent session")
end
