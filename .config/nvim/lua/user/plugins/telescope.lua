local M = {
  'nvim-telescope/telescope.nvim',
  config = function()
    local telescope = require("telescope")
    local icons = require("user.icons")
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
            ["<C-c>"] = function() vim.cmd.stopinsert() end,
            ["<esc>"] = actions.close,
          },
        }
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
  end
}

return M
