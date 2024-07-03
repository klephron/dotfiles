local M = {
  'nvim-telescope/telescope.nvim',
  cmd = { "Telescope" },
  dependencies = {
    "ahmedkhalf/project.nvim",
    "rcarriga/nvim-notify",
    "stevearc/aerial.nvim",
    "folke/noice.nvim",
    "nvim-neorg/neorg",
    "jedrzejboczar/possession.nvim",
    -- "mfussenegger/nvim-dap",
  },
  config = function()
    local telescope = require("telescope")
    local icons = c_require("icons")
    local actions = require("telescope.actions")
    local themes = require('telescope.themes')
    local builtins = require('telescope.builtin')

    local functions = {
      buffer_delete = function(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local bufdelete = require("bufdelete")

        local current_picker = action_state.get_current_picker(prompt_bufnr)
        -- Use bufdelete instead not to break layout
        current_picker:delete_selection(function(selection)
          local force = vim.api.nvim_buf_get_option(selection.bufnr, "buftype") == "terminal"
          local ok = pcall(bufdelete.bufdelete, selection.bufnr, force)
          return ok
        end)
      end
    }

    local ignore_patterns = {
      '%.jpg',
      '%.jpeg',
      '%.png',
      '%.otf',
      '%.ttf',
      '^.git/',
      '^node_modules/',
      '^site-packages/',
      '^.yarn/',
    }

    telescope.setup {
      defaults = {
        prompt_prefix = icons.Telescope,
        path_display = {
          "smart",
          "truncate",
        },
        file_ignore_patterns = ignore_patterns,
        dynamic_preview_title = true,
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
        layout_strategy = "flex",
        layout_config = {
          bottom_pane = {
            height = 25,
            preview_cutoff = 120,
            prompt_position = "top"
          },
          center = {
            height = 0.4,
            preview_cutoff = 40,
            prompt_position = "top",
            width = 0.5
          },
          cursor = {
            height = 0.9,
            preview_cutoff = 40,
            width = 0.8
          },
          horizontal = {
            height = 0.9,
            preview_cutoff = 120,
            prompt_position = "bottom",
            width = 0.8
          },
          vertical = {
            height = 0.9,
            preview_cutoff = 40,
            prompt_position = "bottom",
            width = 0.8
          }
        },
        winblend = 0,
        mappings = {
          i = {
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
            ["<C-f>"] = functions.buffer_delete,
            ["<C-o>"] = function() vim.cmd.stopinsert() end,
            ["<esc>"] = actions.close,
          },
          n = {
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_previous,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_next,
            ["f"] = functions.buffer_delete,
          }
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- no_ignore = false,
        },
        oldfiles = {
          hidden = true,
        },
        live_grep = {
          -- manual usage:
          -- :lua require('telescope.builtin').live_grep({additional_args = function() return {"--no-ignore"} end })
        },
      },
      extensions = {
        aerial = {
          -- Display symbols as <root>.<parent>.<symbol>
          show_nesting = true
        }
      }
    }

    telescope.load_extension("noice")
    telescope.load_extension("notify")
    telescope.load_extension("possession")
    telescope.load_extension('projects')
    telescope.load_extension('aerial')
    -- telescope.load_extension('dap')
  end
}

return M
