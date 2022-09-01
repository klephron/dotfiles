return function()
  local lspsaga = require("lspsaga")
  lspsaga.init_lsp_saga({
    -- "single" | "double" | "rounded" | "bold" | "plus"
    border_style = "single",
    saga_winblend = 0,
    -- when cursor in saga window you config these to move
    move_in_saga = { prev = '<C-p>', next = '<C-n>' },
    -- Error, Warn, Info, Hint
    -- string|fn(entry:table)
    -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
    diagnostic_header = { " ", " ", " ", "ﴞ " },
    show_diagnostic_source = true,
    diagnostic_source_bracket = {},
    -- Lightbulb
    code_action_icon = require("user.icons").diagnostics.lightbulb,
    code_action_num_shortcut = true,
    code_action_lightbulb = {
      enable = true,
      enable_in_insert = true,
      cache_code_action = true,
      sign = false,
      update_time = 150,
      sign_priority = 20,
      virtual_text = true,
    },
    code_action_keys = {
      quit = "q",
      exec = "<CR>",
    },
    -- Lsp_finder
    -- preview lines of lsp_finder and definition preview
    max_preview_lines = 10,
    -- finder icons
    finder_icons = {
      def = '  ',
      ref = '諭 ',
      link = '  ',
    },
    -- finder do lsp request timeout
    finder_request_timeout = 1500,
    -- set antoher colorscheme in preview window
    finder_preview_hl_ns = 0,
    finder_action_keys = {
      open = "o",
      vsplit = "s",
      split = "i",
      tabe = "t",
      quit = "q",
      scroll_down = "<C-f>",
      scroll_up = "<C-b>", -- quit can be a table
    },
    rename_action_quit = "<C-c>",
    rename_in_select = true,
    definition_preview_icon = "  ",
    -- show symbols in winbar must nightly
    symbol_in_winbar = {
      in_custom = false,
      enable = false,
      separator = ' ',
      show_file = true,
      click_support = false,
    },
    -- show outline
    show_outline = {
      win_position = 'right',
      --set special filetype win that outline window split.like NvimTree neotree
      -- defx, db_ui
      win_with = '',
      win_width = 30,
      auto_enter = true,
      auto_preview = true,
      virt_text = '┃',
      jump_key = 'o',
      -- auto refresh when change buffer
      auto_refresh = true,
    },
    -- custom lsp kind
    -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
    custom_kind = {},
    -- like server_filetype_map = { metals = { "sbt", "scala" } }
    server_filetype_map = {},
  })

  vim.cmd("hi clear LspSagaLightBulb")
  vim.cmd("hi LspSagaLightBulb guifg=Yellow")
end
