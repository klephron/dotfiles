vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
local M = {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "s1n7ax/nvim-window-picker",
    config = true,
  },
}

function M.config()
  local neo_tree = require("neo-tree")
  neo_tree.setup({
    filesystem = {
      use_libuv_file_watcher = true,
      follow_current_file = true,
      -- hijack_netrw_behaviour = "open_default",
      window = {
        mappings = {
          ["<space>"] = "none",
          ["o"] = "system_open",
          ["-"] = "navigate_up",
          ["u"] = "focus_parent",
          [";"] = "open",
        }
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          -- Mac OSX
          vim.api.nvim_command("silent !open -g " .. path)
          -- Linux
          vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
        end,
        focus_parent = function(state)
          local node = state.tree:get_node()
          require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
        end
      },
    }
  })
end

return M
