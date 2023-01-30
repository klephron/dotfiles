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
    },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["P"] = function()
          vim.cmd("cd ..")
        end
      }
    }
  })
end

return M
