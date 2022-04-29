local status, lualine = pcall(require, "lualine")
if (not status) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'nightfly',
    section_separators = { left = '', right = '' },
    --section_separators = '',
    component_separators = { left = '', right = '' },
    --component_separators = '',
    disabled_filetypes = {},
    always_divide_middle = true, -- When set to true, left sections i.e. 'a','b' and 'c'
                                 -- can't take over the entire statusline even
                                 -- if neither of 'x', 'y' or 'z' are present.
    globalstatus = true,        -- enable global statusline (have a single statusline
                                 -- at bottom of neovim instead of one for  every window).
                                 -- This feature is only available in neovim 0.7 and higher.
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {{
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0 -- 0 = just filename, 1 = relative path, 2 = absolute path
    }},
    lualine_x = {
      { 'diagnostics', sources = {"nvim_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
    }},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
}
