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
    '.git/',
    '.idea/',
  }

  telescope.setup {
    defaults = {
      prompt_prefix = icons.Telescope .. "",
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
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<CR>"] = actions.select_default,
          ["<C-h>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["<C-/>"] = actions.which_key,
        },
        n = {
          ["<esc>"] = { actions.close, type = "action", opts = { silent = true, nowait = true } }, -- error when trying to press escape
          -- ["<esc>"] = {
          --   "<cmd>lua require('telescope.actions').close(vim.api.nvim_get_current_buf())<cr>",
          --   type = "command", opts = { silent = true, nowait = true }
          -- },
          ["<C-c>"] = actions.close,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["?"] = actions.which_key,
        }
      }
    },
    pickers = {
      find_files = {
        hidden = true,
        no_ignore = true,
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
