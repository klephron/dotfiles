local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then return
end

nvim_tree.setup {
  update_cwd = true,
  view = {
    mappings = {
      list = {
        -- user mappings go here
      },
    },
  },
  hijack_directories = {
    enable = false,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  git = {
    timeout = 1000,
  },
}
