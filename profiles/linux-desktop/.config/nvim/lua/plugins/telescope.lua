return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    "DrKJeff16/project.nvim",
    "rcarriga/nvim-notify",
    "stevearc/aerial.nvim",
    "folke/noice.nvim",
    -- "nvim-neorg/neorg",
    "jedrzejboczar/possession.nvim",
    'nvim-telescope/telescope-ui-select.nvim'
    -- "mfussenegger/nvim-dap",
  },
  event = "UIEnter",
  config = function()
    local utils = require("utils")
    local telescope = require("telescope")
    local icons = require("icons")
    local actions = require("telescope.actions")
    local themes = require("telescope.themes")
    local builtins = require("telescope.builtin")

    telescope.setup {
      defaults = {
        prompt_prefix = icons.Telescope,
        path_display = {
          "smart",
        },
        file_ignore_patterns = {
          '%.jpg',
          '%.jpeg',
          '%.png',
          '%.otf',
          '%.ttf',
          '^.git/',
          '^node_modules/',
          '^site-packages/',
          '^.yarn/',
        },
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
        winblend = 0,
        mappings = {
          i = {
            ["<C-j>"] = actions.cycle_history_next,
            ["<C-k>"] = actions.cycle_history_prev,
            ["<C-o>"] = function() vim.cmd.stopinsert() end,
            ["<esc>"] = actions.close,
          },
          n = {
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_previous,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_next,
          }
        },
      },
      pickers = {
        buffers = {
          mappings = {
            i = {
              ["<C-f>"] = actions.delete_buffer,
            },
            n = {
              ["f"] = actions.delete_buffer,
            }
          }
        },
        find_files = {
          hidden = true,
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
        ["aerial"] = {
          show_nesting = true -- Display symbols as <root>.<parent>.<symbol>
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
          }),
        },
      }
    }

    telescope.load_extension("aerial")
    telescope.load_extension("noice")
    telescope.load_extension("possession")
    telescope.load_extension("projects")
    telescope.load_extension("ui-select")

    utils.set_keynomap("n", "<leader>b", "<cmd>Telescope buffers<cr>", "[telescope] List buffers")
    utils.set_keynomap("n", "<leader>h", "<cmd>Telescope live_grep<cr>", "[telescope] Live grep")
    utils.set_keynomap("n", "<leader>r", "<cmd>Telescope oldfiles<cr>", "[telescope] Live recent files")
    utils.set_keynomap("n", "<leader>s", "<cmd>Telescope find_files<cr>", "[telescope] Find files")
    utils.set_keynomap("n", "<leader>;", "<cmd>Telescope resume<cr>", "[telescope] Resume telescope search")
  end,
}
