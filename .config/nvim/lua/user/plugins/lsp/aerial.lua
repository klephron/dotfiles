local M = {}

local aerial_ok, aerial = safe_require("aerial")
if not aerial_ok then
  return
end

function M.setup()
  aerial.setup({
    backends = { "treesitter", "lsp", "markdown" },

    layout = {
      max_width = { 40, 0.2 },
      width = nil,
      min_width = { 20, 0.1 },

      default_direction = "prefer_right",
      placement = "group",
    },

    close_behavior = "auto",

    default_bindings = true,

    disable_max_lines = 10000,
    disable_max_size = 2000000, -- Default 2MB

    filter_kind = {
      "Class",
      "Constructor",
      "Enum",
      "Function",
      "Interface",
      "Module",
      "Method",
      "Struct",
    },

    highlight_mode = "last",
    highlight_closest = true,
    highlight_on_hover = true,
    highlight_on_jump = 500,

    icons = require("user.icons").kind_icons,

    ignore = {
      unlisted_buffers = true,
      filetypes = {},
      buftypes = "special",
      wintypes = "special",
    },

    link_folds_to_tree = false,
    link_tree_to_folds = true,
    manage_folds = false,
    nerd_font = "auto",

    on_attach = function(bufnr)
      local kmps = require("user.keymaps").aerial
      -- Set keymaps
    end,

    open_automatic = false,
    close_on_select = false,

    on_first_symbols = nil,
    post_jump_cmd = "normal! zz",

    -- (not used for LSP backend)
    update_events = "TextChanged,InsertLeave",

    show_guides = true,
    guides = {
      mid_item = "├─",
      last_item = "└─",
      nested_top = "│ ", -- When there are nested child guides to the right
      whitespace = "  ",
    },

    float = {
      -- Controls border appearance. Passed to nvim_open_win
      border = "rounded",
      relative = "cursor",

      max_height = 0.9,
      height = nil,
      min_height = { 8, 0.1 },

      override = function(conf)
        return conf
      end,
    },

    lsp = {
      diagnostics_trigger_update = true,
      update_when_errors = true,
      update_delay = 300,
    },

    treesitter = {
      update_delay = 300,
    },

    markdown = {
      update_delay = 300,
    },
  })

  -- Telescope integration
  require('telescope').load_extension('aerial')
end

return M
