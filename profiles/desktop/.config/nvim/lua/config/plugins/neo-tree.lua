local M = {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    {
      's1n7ax/nvim-window-picker',
      opts = {
        hint = 'floating-big-letter',
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          bo = {
            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
            buftype = { 'terminal', "quickfix" },
          },
        },
      }
    },
  },
  config = function()
    local neo_tree = require("neo-tree")
    local funcs = require("utils.funcs")

    neo_tree.setup({
      filesystem = {
        -- use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        follow_current_file = {
          enabled = true,
          -- leave_dirs_open = false,
        },
        hijack_netrw_behaviour = "open_default",
        window = {
          position = "current",
          mappings = {
            ["<space>"] = "none",
            ["o"] = "system_open",
            ["-"] = "navigate_up",
            ["u"] = "focus_parent",
            [";"] = "open",
            ["z"] = "none",
            ['zo'] = "expand_all_subnodes",
            ['zO'] = "expand_all_nodes",
            ['zc'] = "close_all_subnodes",
            ['zC'] = "close_all_nodes",
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

    funcs.set_keynomap("n", "<leader>e", "<cmd>Neotree position=right<cr>", "Open neotree")
    funcs.set_keynomap("n", "<leader>E", "<cmd>Neotree toggle position=right<cr>", "Toggle neotree")
    funcs.set_keynomap("n", "<leader>l", "<cmd>Neotree<cr>", "Open neotree netrw")
  end
}

return M
