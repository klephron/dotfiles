local M = {
  "rmagatti/auto-session",
  cmd = { "SearchSession", "RestoreSession", "Autosession", "SaveSession" },
  enabled = true,
}

function M.config()
  local auto_session = require("auto-session")
  auto_session.setup({
    log_level = 'error',
    auto_session_root_dir = vim.fn.stdpath('cache') .. "/auto-session/",
    auto_session_enabled = true,
    auto_save_enabled = false,
    auto_restore_enabled = false,
    auto_session_use_git_branch = nil,
    cwd_change_handling = false,
  })

  -- Manually save session
  us.augroup("_AutoSession", {
    {
      event = "VimLeavePre",
      pattern = "*",
      command = "SaveSession",
    }
  })
end

return M
