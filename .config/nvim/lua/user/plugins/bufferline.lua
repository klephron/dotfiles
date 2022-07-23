return function()
  local bufferline = require("bufferline")

  bufferline.setup {
    options = {
      mode = "buffers",
      numbers = "none",
      close_command = "bdelete! %d",
      right_mouse_command = "bdelete! %d",
      left_mouse_command = "buffer %d",

      indicator_icon = '▎',
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',

      max_name_length = 25,
      max_prefix_length = 25, -- prefix used when a buffer is de-duplicated
      tab_size = 18,
      separator_style = { "", "" },

      diagnostics = false,
      diagnostics_update_in_insert = false,

      offsets = {
      --  { filetype = "NvimTree", text = "", text_align = "center", padding = 1 }
      },

      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_buffer_default_icon = true,
      show_close_icon = true,
      show_tab_indicators = true,

      persist_buffer_sort = true,
      enforce_regular_tabs = true,
      always_show_bufferline = true,
    },
    highlights = {
      fill = {
        guibg = { attribute = "bg", highlight = "TabLine" },
      },
      tab = {
        guifg = { attribute = "fg", highlight = "TabLine" },
        guibg = { attribute = "bg", highlight = "TabLine" },
      },
      tab_selected = {
        guifg = { attribute = "fg", highlight = "TabLineSel" },
        guibg = { attribute = "bg", highlight = "Normal" },
        gui = "bold",
      },
      tab_close = {
        guifg = { attribute = "fg", highlight = "TabLine" },
        guibg = { attribute = "bg", highlight = "TabLine" },
      },
      separator = {
        guifg = { attribute = "bg", highlight = "TabLine" }, -- between tabs and buffers
        guibg = { attribute = "bg", highlight = "TabLine" }, -- border between tabs and buffers
      },
      separator_selected = {
        guifg = { attribute = "bg", highlight = "TabLine" }, -- small border
        guibg = { attribute = "bg", highlight = "Normal" }, -- close to tab
      },
      buffer_selected = {
        guifg = { attribute = "fg", highlight = "Normal" },
        guibg = { attribute = "bg", highlight = "Normal" },
      },
      background = {
        guifg = { attribute = "fg", highlight = "TabLine" }, -- hidden buffers
        guibg = { attribute = "bg", highlight = "TabLine" },
      },
      close_button = {
        guifg = { attribute = "fg", highlight = "TabLine" }, -- close button of a buffer
        guibg = { attribute = "bg", highlight = "TabLine" },
      },
      indicator_selected = {
        guifg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
        guibg = { attribute = "bg", highlight = "Normal" },
      },
      modified = {
        guifg = { attribute = "fg", highlight = "TabLine" },
        guibg = { attribute = "bg", highlight = "TabLine" },
      },
      modified_selected = {
        guifg = { attribute = "fg", highlight = "Normal" },
        guibg = { attribute = "bg", highlight = "Normal" },
      },

      -- buffer_visible = {
      --   guifg = { attribute = "bg", highlight = "DiffAdd" },
      --   guibg = { attribute = "bg", highlight = "DiffChange" },
      -- },
      -- duplicate_selected = {
      --   guifg = { attribute = "bg", highlight = "DiffAdd" },
      --   guibg = { attribute = "bg", highlight = "DiffChange" },
      --   gui = "italic",
      -- },
      -- duplicate_visible = {
      --   guifg = { attribute = "bg", highlight = "DiffAdd" },
      --   guibg = { attribute = "bg", highlight = "DiffChange" },
      --   gui = "italic",
      -- },
      -- duplicate = {
      --   guifg = { attribute = "bg", highlight = "DiffAdd" },
      --   guibg = { attribute = "bg", highlight = "DiffChange" },
      --   gui = "italic",
      -- },
      -- modified_visible = {
      --   guifg = { attribute = "fg", highlight = "TabLine" },
      --   guibg = { attribute = "bg", highlight = "TabLine" },
      -- },
    },
  }
end
