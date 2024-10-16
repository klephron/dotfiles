vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
local M = {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    {
      's1n7ax/nvim-window-picker',
      version = '2.*',
      config = function()
        require 'window-picker'.setup({
          hint = 'floating-big-letter',
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            bo = {
              filetype = { 'neo-tree', "neo-tree-popup", "notify" },
              buftype = { 'terminal', "quickfix" },
            },
          },
        })
      end,
    },
  },
  config = function()
    local neo_tree = require("neo-tree")
    local com_bjarksen = require("config.plugins.neo-tree.mrbjarksen")

    neo_tree.setup({
      filesystem = {
        use_libuv_file_watcher = true,
        follow_current_file = {
          enabled = true,
          -- leave_dirs_open = false,
        },
        hijack_netrw_behaviour = "open_default",
        window = {
          position = "right",
          mappings = {
            ["<space>"] = "none",
            ["o"] = "system_open",
            ["-"] = "navigate_up",
            ["u"] = "focus_parent",
            [";"] = "open",
            ["z"] = "none",
            ['zo'] = com_bjarksen.open_fold,
            ['zO'] = com_bjarksen.open_folds_rec,
            ['zc'] = com_bjarksen.close_fold,
            ['zC'] = "close_all_subnodes",
            ['za'] = com_bjarksen.toggle_fold,
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
  end,
  keys = {
    { "<leader>e",      "<cmd>Neotree<cr>",                  desc = "neo-tree" },
    { "<leader>E",      "<cmd>Neotree toggle<cr>",           desc = "neo-tree: Toggle" },
    { "<localleader>e", "<cmd>Neotree position=current<cr>", desc = "Neotree position=current" },
  }
}

return M
