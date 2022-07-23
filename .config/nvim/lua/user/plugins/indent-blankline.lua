return function()
  local ib_ok, indentline = safe_require("indent_blankline")
  if not ib_ok then
    return
  end
  indentline.setup {
    enabled = true,
    use_treesitter = false,

    char = '|', -- ┆ ┊ 
    char_highlight_list = {},

    char_blankline = '|',
    space_char_blankline = ' ',
    space_char_highlight_list = {},
    space_char_blankline_highlight_list = {},

    viewport_buffer = 20,

    show_first_indent_level = true,
    show_trailing_blankline_indent = false,
    show_end_of_line = false,
    show_foldtext = false,

    filetype_exclude = {
      'txt', 'log', 'help'
    },
    buftype_exclude = {
      'terminal', 'nofile'
    },

    context_char = '|',
    context_char_blankline = '|',
    show_current_context = true,
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
