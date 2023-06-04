local M = {
  "rmagatti/auto-session",
  cmd = {  "Autosession", "SessionRestore", "SessionSave" },
  enabled = true,
}

function M.config()

  local close_conflicted = { "tabdo Neotree close", "tabdo AerialCloseAll" }

  local auto_session = require("auto-session")
  auto_session.setup({
    log_level = 'info',
    auto_session_root_dir = vim.fn.stdpath('cache') .. "/auto-session/",
    auto_session_enabled = true,
    auto_save_enabled = false,
    auto_restore_enabled = false,
    auto_session_use_git_branch = nil,
    cwd_change_handling = false,
    -- hooks
    pre_save_cmds = close_conflicted,
    pre_restore_cmds = close_conflicted,
  })

  -- Manually save session
  us.augroup("SaveSessionManually", {
    {
      event = "VimLeave",
      pattern = "*",
      command = "SessionSave",
    }
  })
end

return M
