return function()
  local status_ok, nvim_tree = safe_require('nvim-tree')
  if not status_ok then
    return
  end

  local config_status_ok, nvim_tree_config = safe_require("nvim-tree.config")
  if not config_status_ok then return
  end

  nvim_tree.setup {
    disable_netrw = true,
    open_on_setup = false,
    respect_buf_cwd = false,
    update_cwd = true,
    sync_root_with_cwd = true,
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    git = {
      enable = true,
      ignore = true, -- Toggle on I
      timeout = 1000,
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = true,
        restrict_above_cwd = false,
      },
    },
    view = {
      width = 30,
      side = "left",
      mappings = {
        list = {
          { key = "h", action = "split" },
          { key = "v", action = "vsplit" },
          { key = { "e", "<BS>", }, action = "close_node" },
        },
      },
    },
  }
end
