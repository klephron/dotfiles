return function()
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
        -- shorten = { len = 1, exclude = { 3, -1 } },
        -- "hidden",
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

          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,

          ["<C-o>"] = function() vim.cmd.stopinsert() end,
          ["<esc>"] = actions.close,
          -- ["<C-]>"] = actions.close,

          ["<CR>"] = actions.select_default,

          ["<C-s>"] = actions.select_horizontal,
          ["<A-s>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<A-v>"] = actions.select_vertical,

          ["<C-t>"] = actions.select_tab,
          ["<A-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["<C-/>"] = actions.which_key,
        },
        n = {
          ["<esc>"] = { actions.close, type = "action", opts = { silent = true, nowait = true } },
          ["?"] = actions.which_key,
        }
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
