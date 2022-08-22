return function()
  local indentline = require("indent_blankline")
  local icons = require("user.icons").indentline

  indentline.setup {
    enabled = true,
    use_treesitter = false,

    char = icons.char, -- ┆ ┊ 
    char_blankline = icons.char,
    space_char_blankline = ' ',
    char_highlight_list = {},
    space_char_highlight_list = {},
    space_char_blankline_highlight_list = {},

    viewport_buffer = 20,

    show_first_indent_level = true,
    show_trailing_blankline_indent = false,
    show_end_of_line = true,
    show_foldtext = false,

    filetype_exclude = {
      'txt', 'log', 'help'
    },
    buftype_exclude = {
      'terminal', 'nofile'
    },

    context_char = icons.context_char,
    context_char_blankline = icons.context_char,
    show_current_context = false,
    show_current_context_start = false,
    show_current_context_start_on_current_line = false,

    use_treesitter_scope = false,
    context_patterns = {
      'class',
      'function',
      'method',
      -- 'block',
      'list_literal',
      'selector',
      '^if',
      '^table',
      'if_statement',
      'while',
      'for',
    },
  }
end
