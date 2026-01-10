local M = {
  "nvim-lualine/lualine.nvim",
  event = "UIEnter",
  config = function()
    local lualine = require("lualine")
    local lualine_progress = require("lualine.components.progress")
    local terminal = require("toggleterm.terminal")

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    local components = {
      mode = {
        "mode",
        fmt = function(str)
          return str
        end,
      },
      diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = { error = " ", warn = " " },
        colored = false,
        update_in_insert = false,
        always_visible = true,
      },
      diff = {
        "diff",
        colored = false,
        symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
        cond = hide_in_width
      },
      filename = {
        'filename',
        file_status = true, -- Displays file status (readonly status, modified status)
        -- 0: Just the filename
        -- 1: Relative path
        -- 2: Absolute path
        -- 3: Absolute path, with tilde as the home directory
        path = 0,
        shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
        symbols = {
          modified = '[+]',      -- Text to show when the file is modified.
          readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
          unnamed = '[No Name]', -- Text to show for unnamed buffers.
        },
        fmt = function()
          local par_dir = vim.fn.fnamemodify(vim.fn.expand('%:h'), ':t')
          local fname = vim.fn.expand('%:t')
          if par_dir == "." then
            return fname
          else
            return par_dir .. '/' .. fname
          end
        end
      },
      filetype = {
        "filetype",
        icons_enabled = false,
        icon = nil,
      },
      branch = {
        "branch",
        icons_enabled = true,
        icon = "",
      },
      location = {
        "location",
        padding = 0,
      },
      spaces = function()
        return "spaces:" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
      end,
      session_name = function()
        return require('possession.session').get_session_name() or ''
      end,
      hostname = {
        function()
          return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or ""
        end,
        padding = { right = 1, left = 1 },
        separator = { left = "", right = "" },
      },
      toggleterm_name = function()
        local idx = vim.b.toggle_number
        local term = terminal.get(idx, true)
        return 'term[' .. term.display_name .. '#' .. idx .. ']'
      end
    }

    local extensions = {
      toggleterm = {
        sections = {
          lualine_a = { components.toggleterm_name },
        },
        filetypes = { 'toggleterm' }
      }
    }


    lualine.setup({
      options = {
        icons_enabled = true,
        -- theme = "vscode",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { components.mode },
        lualine_b = { components.hostname, components.branch, components.diagnostics },
        lualine_c = { components.session_name, components.filename },
        lualine_x = { "aerial" },
        lualine_y = { components.diff, "fileformat", components.spaces, components.filetype, },
        lualine_z = { components.location, lualine_progress }
      },
      inactive_sections = {
        lualine_a = { components.mode },
        lualine_b = { components.branch },
        lualine_c = { components.session_name, components.filename },
        lualine_x = { "aerial", "fileformat", components.filetype, },
        lualine_y = {},
        lualine_z = { components.location, lualine_progress },
      },
      tabline = {},
      extensions = { "aerial", "nvim-tree", "nvim-dap-ui", "quickfix", extensions.toggleterm },
    })
  end
}

return M
