return function()
  local lualine = require("lualine")

  local fn = vim.fn

  local function color(val)
    if type(val) == "string" then
      return val
    else
      return fn.synIDattr(fn.synIDtrans(fn.hlID(val[1])), val[2] .. "#")
    end
  end

  -- CUSTOMIZATION
  local colors = {
    color1 = color({ "TabLine", "fg" }),
    color2 = color({ "TabLine", "bg" }),
    color3 = color("#d4d4d4"),
    color4 = color("#007acc"),
  }

  local custom_theme = {
    normal = {
      a = { fg = colors.color1, bg = colors.color2, gui = 'bold' },
      b = { fg = colors.color1, bg = colors.color2, gui = 'bold' },
      c = { fg = colors.color1, bg = colors.color2, gui = 'bold' },
      x = { fg = colors.color1, bg = colors.color2, gui = 'bold' },
      y = { fg = colors.color1, bg = colors.color2, gui = 'bold' },
      z = { fg = colors.color1, bg = colors.color2, gui = 'bold' },
    },
    insert = {
      a = { fg = colors.color1, bg = colors.color2, gui = 'bold' },
    },
    visual = {
      a = { fg = colors.color1, bg = colors.color2, gui = 'bold' },
    },
    replace = {
      a = { fg = colors.color1, bg = colors.color2, gui = 'bold' },
    },
    inactive = {
      a = { fg = colors.color1, bg = colors.color2, gui = 'bold' },
    },
  }

  local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end

  -- COMPONENTS
  local mode = {
    "mode",
    fmt = function(str)
      return str
    end,
  }

  local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = false,
    update_in_insert = false,
    always_visible = true,
  }

  local diff = {
    "diff",
    colored = false,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width
  }

  local filename = {
    'filename',
    file_status = true, -- Displays file status (readonly status, modified status)
    -- 0: Just the filename
    -- 1: Relative path
    -- 2: Absolute path
    -- 3: Absolute path, with tilde as the home directory
    path = 0,
    shorting_target = 40, -- Shortens path to leave 40 spaces in the window
    symbols = {
      modified = '[+]', -- Text to show when the file is modified.
      readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
      unnamed = '[No Name]', -- Text to show for unnamed buffers.
    }
  }

  local filetype = {
    "filetype",
    icons_enabled = false,
    icon = nil,
  }

  local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
  }

  local location = {
    "location",
    padding = 0,
  }

  -- cool function for progress
  --[[ local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end ]]

  local progress = require("lualine.components.progress")

  local spaces = function()
    return "spaces:" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end

  local session_ok, auto_session = safe_require('auto-session-library')
  local function session()
    if session_ok then
      return auto_session.current_session_name()
    end
  end

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = custom_theme,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { mode },
      lualine_b = { branch, diagnostics },
      lualine_c = { filename },
      lualine_x = { "aerial" },
      lualine_y = { session, diff },
      lualine_z = { spaces, "encoding", location, progress }
    },
    inactive_sections = {
      lualine_a = { mode },
      lualine_b = { branch },
      lualine_c = { filename },
      lualine_x = {"aerial" },
      lualine_y = { session },
      lualine_z = { "encoding", location, progress },
    },
    tabline = {},
    extensions = {},
  })
end
