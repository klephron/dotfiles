local M = {
  'nvim-telescope/telescope.nvim',
  cmd = { "Telescope" },
  dependencies = {
    "ahmedkhalf/project.nvim",
    "rcarriga/nvim-notify",
    "stevearc/aerial.nvim",
    "folke/noice.nvim",
    -- "nvim-neorg/neorg",
    "jedrzejboczar/possession.nvim",
    -- "mfussenegger/nvim-dap",
  },
  config = function()
    local telescope = require("telescope")
    local icons = require("config.icons")
    local actions = require("telescope.actions")
    local themes = require('telescope.themes')
    local builtins = require('telescope.builtin')

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
        aerial = {
          show_nesting = true -- Display symbols as <root>.<parent>.<symbol>
        }
      }
    }

    telescope.load_extension("noice")
    telescope.load_extension("possession")
    telescope.load_extension('projects')
    telescope.load_extension('aerial')
  end,
  keys = {
    { "<leader>b", "<cmd>Telescope buffers<cr>",    desc = "List buffers" },
    { "<leader>h", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
    { "<leader>r", "<cmd>Telescope oldfiles<cr>",   desc = "List recent files" },
    { "<leader>s", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>;", "<cmd>Telescope resume<cr>",     desc = "Resume telescope search" },
  }
}

return M
