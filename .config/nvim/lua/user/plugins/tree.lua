return function()
  local nvim_tree = require('nvim-tree')
  local dispatch = require("nvim-tree.actions.dispatch").dispatch

  -- Custom functions
  local function open_file_close_nvim_tree(node)
    dispatch("open_file")
    if not node.nodes then
      vim.cmd("NvimTreeClose")
    end
  end

  nvim_tree.setup {
    disable_netrw = true,
    open_on_setup = false,
    respect_buf_cwd = true,
    sync_root_with_cwd = false,
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable = true,
      update_root = true,
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
        global = false,
        restrict_above_cwd = false,
      },
    },
    -- log = {
    --   enable = true,
    --   types = { all = true, },
    -- },
    view = {
      width = 30,
      side = "left",
      mappings = {
        list = {
          -- DEFAULT MAPPINGS
          { key = { "<CR>", "<2-LeftMouse>" }, action = "edit" },
          { key = "<C-e>", action = "edit_in_place" },
          { key = "O", action = "edit_no_picker" },
          { key = { "<C-]>", "<2-RightMouse>" }, action = "cd" },
          { key = "<C-t>", action = "tabnew" },
          { key = "<", action = "prev_sibling" },
          { key = ">", action = "next_sibling" },
          { key = "P", action = "parent_node" },
          { key = "<Tab>", action = "preview" },
          { key = "K", action = "first_sibling" },
          { key = "J", action = "last_sibling" },
          { key = "I", action = "toggle_git_ignored" },
          { key = "H", action = "toggle_dotfiles" },
          { key = "U", action = "toggle_custom" },
          { key = "R", action = "refresh" },
          { key = "a", action = "create" },
          { key = "d", action = "remove" },
          { key = "D", action = "trash" },
          { key = "r", action = "rename" },
          { key = "<C-r>", action = "full_rename" },
          { key = "x", action = "cut" },
          { key = "c", action = "copy" },
          { key = "p", action = "paste" },
          { key = "y", action = "copy_name" },
          { key = "Y", action = "copy_path" },
          { key = "gy", action = "copy_absolute_path" },
          { key = "[e", action = "prev_diag_item" },
          { key = "[c", action = "prev_git_item" },
          { key = "]e", action = "next_diag_item" },
          { key = "]c", action = "next_git_item" },
          { key = "-", action = "dir_up" },
          { key = "s", action = "system_open" },
          { key = "f", action = "live_filter" },
          { key = "F", action = "clear_live_filter" },
          { key = "q", action = "close" },
          { key = "W", action = "collapse_all" },
          { key = "E", action = "expand_all" },
          { key = "S", action = "search_node" },
          { key = ".", action = "run_file_command" },
          { key = "<C-k>", action = "toggle_file_info" },
          { key = "g?", action = "toggle_help" },
          { key = "m", action = "toggle_mark" },
          { key = "bmv", action = "bulk_move" },
          -- user defined
          { key = { "e", "<BS>" }, action = "close_node" },
          { key = { "<C-v>", "v" }, action = "vsplit" },
          { key = { "<C-x>", "h" }, action = "split" },
          -- custom actions
          { key = { "o" }, action = "open_file_close_nvim_tree", action_cb = open_file_close_nvim_tree },
        },
      },
    },
  }
end
