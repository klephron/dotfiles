local M = {
  "rmagatti/auto-session",
  enabled = true,
  dependencies = {
    {
      "rmagatti/session-lens",
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
        require('telescope').load_extension("session-lens")
      end
    }
  }
}

function M.config()
  local auto_session = require("auto-session")
  auto_session.setup({
    log_level = 'error',
    auto_session_root_dir = vim.fn.stdpath('cache') .. "/auto-session/",
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    auto_session_use_git_branch = nil,
    cwd_change_handling = {
      restore_upcoming_session = false,
    }
  })
end

return M
