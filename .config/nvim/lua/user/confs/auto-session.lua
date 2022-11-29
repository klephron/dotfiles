return function()
  local auto = require("auto-session")

  -- NOTE: Waiting for merge: https://github.com/rmagatti/auto-session/pull/89

  local function nvim_tree_pre_save()
    local dapui_ok, dapui = pcall(require, "dapui")
    if dapui_ok then dapui.close({}) end

    vim.cmd("tabdo NvimTreeClose")
    vim.cmd("tabdo AerialCloseAll")
  end

  local function close_all_floating_wins()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative ~= '' then
        vim.api.nvim_win_close(win, false)
      end
    end
  end

  auto.setup({
    log_level = 'error',
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath('cache') .. "/sessions/",
    auto_session_enabled = true,
    auto_session_create_enabled = true,
    auto_save_enabled = false,
    auto_restore_enabled = false,
    -- auto_session_suppress_dirs = { "~/" },
    -- auto_session_allowed_dirs = {},
    auto_session_use_git_branch = nil,
    bypass_session_save_file_types = nil,
    cwd_change_handling = false,
    -- cwd_change_handling = {
    --   restore_upcoming_session = false,
    --   pre_cwd_changed_hook = nil,
    --   post_cwd_changed_hook = nil,
    -- },
    -- hooks
    pre_save_cmds = { nvim_tree_pre_save, close_all_floating_wins },
    post_restore_cmds = {},
  })
  
  us.augroup("_AutoSession", {
    {
      event = "VimLeavePre",
      pattern = "*",
      command = "SaveSession",
    }
  })
end
