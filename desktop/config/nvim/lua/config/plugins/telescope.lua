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
    local icons = require("config.icons")
    local actions = require("telescope.actions")
    local themes = require('telescope.themes')
    local builtins = require('telescope.builtin')

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
    telescope.load_extension("possession")
    telescope.load_extension('projects')
    telescope.load_extension('aerial')
  end,
  keys = {
    { "<leader>b", "<cmd>Telescope buffers<cr>",                                                                                          desc = "telescope: Buffers" },
    { "<leader>h", "<cmd>Telescope live_grep<cr>",                                                                                        desc = "telescope: Live grep" },
    { "<leader>r", "<cmd>Telescope oldfiles<cr>",                                                                                         desc = "telescope: Recent files" },
    { "<leader>s", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", desc = "telescope: Find files" },
  }
}

return M
