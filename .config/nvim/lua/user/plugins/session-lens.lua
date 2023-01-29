local M = {
  {
    "rmagatti/session-lens",
    dependencies = {
      "rmagatti/auto-session",
    },
    lazy = true,
    config = function()
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
    end
  }
}

return M
