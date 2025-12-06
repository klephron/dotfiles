local C = {
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
  end,

  up = function(state)
    local node = state.tree:get_node()
    if not node then return end
    require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
  end,

  down = function(state)
    local node = state.tree:get_node()

    if not node or not (node.type == "directory" or node:has_children()) then
      return
    end

    local function callback()
      if node:has_children() then
        require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
      end
    end

    if node:is_expanded() then
      callback()
      return
    end

    state.commands.toggle_node(state)

    local timer = vim.uv.new_timer()
    local start = vim.uv.now()

    timer:start(0, 10, function()
      if node:is_expanded() then
        timer:stop()
        timer:close()
        vim.schedule(callback)
      elseif vim.uv.now() - start > 500 then
        timer:stop()
        timer:close()
      end
    end)
  end,

  open = function(state)
    require("neo-tree.ui.renderer").focus_node(state, state.tree:get_node():get_id())
    require("neo-tree.sources.filesystem.commands").open(state)
  end,

  open_split = function(state)
    require("neo-tree.ui.renderer").focus_node(state, state.tree:get_node():get_id())
    require("neo-tree.sources.filesystem.commands").open_split(state)
  end,

  open_vsplit = function(state)
    require("neo-tree.ui.renderer").focus_node(state, state.tree:get_node():get_id())
    require("neo-tree.sources.filesystem.commands").open_vsplit(state)
  end,
}

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
      clipboard = {
        sync = "universal",
      },
      filesystem = {
        use_libuv_file_watcher = true,
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
            ["z"] = "none",
            ["o"] = "system_open",
            ["-"] = "navigate_up",
            ["u"] = "close_all_subnodes",
            ["h"] = "up",
            ["l"] = "down",
            [";"] = "open",
            ['zo'] = "expand_all_subnodes",
            ['zO'] = "expand_all_nodes",
            ['zc'] = "close_all_subnodes",
            ['zC'] = "close_all_nodes",
          }
        },
        commands = {
          system_open = C.system_open,
          focus_parent = C.focus_parent,
          up = C.up,
          down = C.down,
          open = C.open,
          open_split = C.open_split,
          open_vsplit = C.open_vsplit,
        },
      }
    })

    funcs.set_keynomap("n", "<leader>e", "<cmd>Neotree position=right<cr>", "Open neotree")
    funcs.set_keynomap("n", "<leader>E", "<cmd>Neotree toggle position=right<cr>", "Toggle neotree")
    funcs.set_keynomap("n", "<leader>l", "<cmd>Neotree position=current<cr>", "Open neotree netrw")
  end
}

return M
