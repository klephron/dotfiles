return function()
  local auto = require("auto-session")

  -- NOTE: Waiting for merge: https://github.com/rmagatti/auto-session/pull/89

  local function nvim_tree_pre_save()
    vim.cmd("tabdo NvimTreeClose")
  end

  auto.setup {
    log_level = 'error',
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath('data') .. "/sessions/",
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = false,
    -- auto_session_suppress_dirs = { "~/" },
    auto_session_use_git_branch = nil,
    -- hooks
    pre_save_cmds = { nvim_tree_pre_save },
    post_restore_cmds = {},
  }
end
